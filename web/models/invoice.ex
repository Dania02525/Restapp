defmodule Restapp.Invoice do
  use Ecto.Model

  schema "invoices" do
    field :contact_id, :integer
    field :po_number
    field :note
    field :txn_date, Ecto.Date
    timestamps

    has_many :invoice_items, Restapp.InvoiceItem
  end

  def changeset(params, :create) do   
    %Restapp.Invoice{}
    |> cast(params, ~w(contact_id), ~w(po_number note txn_date))
  end

  def changeset(params, :update, invoice) do   
    invoice
    |> cast(params, [], ~w(contact_id po_number note txn_date))
  end

end