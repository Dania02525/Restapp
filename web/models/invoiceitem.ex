defmodule Restapp.InvoiceItem do
  use Ecto.Model

  schema "invoice_items" do
    field :sku
    field :description
    field :cost, :decimal
    field :msrp, :decimal
    field :sell_price, :decimal
    field :tax, :decimal

    belongs_to :invoice, Restapp.Invoice
  end

  def changeset(params, :create) do
    %Restapp.InvoiceItem{}
    |> cast(params, ~w(sell_price), ~w(invoice_id sku description cost msrp tax))
  end

end
