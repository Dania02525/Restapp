defmodule Restapp.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
  	create table(:invoices) do
  		add :contact_id, :integer
  		add :po_number
  		add :txn_date, :date
  		add :note

  		timestamps
  	end
  end
end
