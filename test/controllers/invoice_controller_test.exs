defmodule Restapp.InvoiceControllerTest do
  use Restapp.ConnCase

  test "add invoice" do
      {:ok, token} = Joken.encode(%{aud: "user"})
      body = "{\"data\":{\"contact_id\":\"2\",\"txn_date\":\"2015-03-31\",\"note\":\"test note\",\"po_number\":\"18754b\",
      \"items\":[
      {\"product_id\":\"1\",\"income_account_id\":\"1\",\"sku\":\"6558\",\"description\":\"widget\",\"sell_price\":\"18.43\",\"cost\":\"7.24\",\"msrp\":\"19.99\",\"tax\":\"1.48\"},
      {\"product_id\":\"2\",\"income_account_id\":\"2\",\"sku\":\"8000\",\"description\":\"gadget\",\"sell_price\":\"3.36\",\"cost\":\"1.73\",\"msrp\":\"12.64\",\"tax\":\"0.34\"}
      ]}}" 
    response = conn()
                |> put_req_header("content-type", "application/json")
                |> put_req_header("token", token)
                |> post("/api/invoices", body)  

    assert response.status == 201   
  end

  test "get invoices" do
    {:ok, token} = Joken.encode(%{aud: "user"})
    response = conn()
                |> put_req_header("content-type", "application/json")
                |> put_req_header("token", token)
                |> get("/api/invoices")
    assert response.status == 200
  end  

end
