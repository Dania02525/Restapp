defmodule Restapp.InvoiceView do
  use Restapp.Web, :view
  alias Restapp.InvoiceItemView
  alias Restapp.Formatter

  def render("index.json", %{invoices: invoices}) do
    for invoice <- invoices do
      render("show.json", data: invoice)
    end 
  end

  def render("manyflat.json", %{invoices: invoices}) do
    for invoice <- invoices do
      render("flat.json", data: invoice)
    end 
  end

  def render("show.json", %{data: data}) do
    %{
      id: data.id,
      po_number: data.po_number,
      txn_date: data.txn_date,
      note: data.note,
      invoice_items: InvoiceItemView.render("manyflat.json", invoice_items: data.invoice_items)
    } 
  end

  def render("flat.json", %{data: data}) do
    %{
      id: data.id,
      po_number: data.po_number,
      txn_date: data.txn_date,
      note: data.note,
    } 
  end

end
