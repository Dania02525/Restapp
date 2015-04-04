defmodule Restapp.InvoiceController do
  use Restapp.Web, :controller
  alias Restapp.Repo
  alias Restapp.Invoice
  alias Restapp.InvoiceItem

  plug :action

  def index(conn, _params) do
    invoices = Repo.all(Invoice)	
                |> Repo.preload([:invoice_items])
    render conn, "index.json", invoices: invoices	   
  end

  def show(conn, %{"id" => id}) do
    invoice = Repo.get!(Invoice, id)
              |> Repo.preload([:invoice_items])
    render conn, "show.json", data: invoice
  end

  def create(conn, params) do
    invoice = Invoice.changeset(params["data"], :create)
    items   = Enum.map(params["includes"], &InvoiceItem.changeset(&1, :create))

    if invoice.valid? && Enum.all?(items, & &1.valid?) do
      Repo.transaction fn ->
        invoice = Repo.insert(invoice)
        Enum.map(items, fn item ->
          item = Ecto.Changeset.change(item, invoice_id: invoice.id)
          Repo.insert(item)
        end)
      end
      json conn |> put_status(201), %{"message" => "Created"}
    else
      errors = Enum.map(items, & (&1.errors))
                |> Enum.into([invoice.errors])
                |> Enum.map(& (Enum.into(&1, %{})))
      json conn |> put_status(400), %{"message" => errors}
    end
  end

  def update(conn, params) do
    thisinvoice = Repo.get!(Invoice, params["id"]) |> Repo.preload([:invoice_items])   
    matchitems = thisinvoice.invoice_items
    invoice = Invoice.changeset(params["data"], :update, thisinvoice)
    items   = Enum.map(params["includes"], &InvoiceItem.changeset(&1, :create))

    if invoice.valid? && Enum.all?(items, & &1.valid?) do
      Repo.transaction fn ->
        invoice = Repo.update(invoice)
        Enum.map(matchitems, fn item ->
          Repo.delete(item)
        end)
        Enum.map(items, fn item ->
          item = Ecto.Changeset.change(item, invoice_id: invoice.id)
          Repo.insert(item)
        end)
      end
      json conn |> put_status(200), %{"message" => "OK"}
    else
      errors = Enum.map(items, & (&1.errors))
                |> Enum.into([invoice.errors])
                |> Enum.map(& (Enum.into(&1, %{})))
      json conn |> put_status(400), %{"message" => errors}
    end
  end

  def delete(conn, params) do
    thisinvoice = Repo.get!(Invoice, params["id"]) |> Repo.preload([:invoice_items])
    items = thisinvoice.invoice_items
    status = Repo.transaction fn ->
      Repo.delete(thisinvoice)
      Enum.map(items, fn item ->
        Repo.delete(item)
      end)
    end
    case status do
      {:ok, message} ->
        json conn |> put_status(200), %{"message" => "OK"}
      {:error, errors} ->
        json conn |> put_status(400), %{"message" => errors}
    end
  end

end
