defmodule Restapp.Repo.Migrations.CreateIncoiceItems do
  use Ecto.Migration

  def change do
  	create table(:invoice_items) do
  		add :invoice_id, :integer
  		add :sku
  		add :description
  		add :cost, :numeric, precision: 16, scale: 2, default: 0
  		add :msrp, :numeric, precision: 16, scale: 2, default: 0
  		add :sell_price, :numeric, precision: 16, scale: 2, default: 0
  		add :tax, :numeric, precision: 16, scale: 2, default: 0
  	end
  end
end
