defmodule Restapp.InvoiceControllerTest do
  use ExUnit.Case, async: false
  use Plug.Test
  alias Restapp.Repo
  alias Ecto.Adapters.SQL


  @opts Restapp.Router.init([])

  setup_all do
    SQL.begin_test_transaction(Repo)

    on_exit fn ->
      SQL.rollback_test_transaction(Repo)
    end
  end

  test "json" do
      body = "{\"data\":{\"contact_id\":\"2\",\"txn_date\":\"2015-03-31\",\"note\":\"test note\",\"po_number\":\"18754b\"},
      \"includes\":[
      {\"product_id\":\"1\",\"income_account_id\":\"1\",\"sku\":\"6558\",\"description\":\"widget\",\"sell_price\":\"18.43\",\"cost\":\"7.24\",\"msrp\":\"19.99\",\"tax\":\"1.48\"},
      {\"product_id\":\"2\",\"income_account_id\":\"2\",\"sku\":\"8000\",\"description\":\"gadget\",\"sell_price\":\"3.36\",\"cost\":\"1.73\",\"msrp\":\"12.64\",\"tax\":\"0.34\"}
      ]}"
    response = Restapp.Router.call(conn(:post, "/invoices",  body, headers: [{"content-type", "application/json"}]) |> Plug.Conn.fetch_params(), @opts)
    assert response.status == 201   
  end

  test "get index" do
    response = Restapp.Router.call(conn(:get, "/invoices") |> Plug.Conn.fetch_params(), @opts)
    assert response.status == 200
  end  

end
