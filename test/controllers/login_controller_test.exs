defmodule Restapp.LoginControllerTest do
  use Restapp.ConnCase

  test "login user" do
    body = "{\"data\":{\"username\":\"user\",\"password\":\"password\"}}"
    response = conn()
                 |> put_req_header("content-type", "application/json")
                 |> post("/login", body)                
    IO.puts(response.resp_body)
    assert response.status == 200  
  end  

end