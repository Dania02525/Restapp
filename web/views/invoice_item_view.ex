defmodule Restapp.InvoiceItemView do
  use Restapp.Web, :view
  alias Restapp.Formatter

  def render("manyflat.json", %{invoice_items: invoice_items}) do
     for invoice_item <- invoice_items do
      render("flat.json", data: invoice_item)
     end 
  end

  def render("flat.json", %{data: data}) do
     %{
      sku: data.sku,
      description: data.description,
      cost: Formatter.numeric(data.cost),
      msrp: Formatter.numeric(data.msrp),
      sell_price: Formatter.numeric(data.sell_price),
      tax: Formatter.numeric(data.tax)
    } 
  end

end
