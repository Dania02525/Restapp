defmodule Restapp.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Plug.Parsers, parsers: [ :json],
                       pass: ["application/json"],
                       json_decoder: Poison
  end

  scope "/", Restapp do
    pipe_through :api 
    
    resources "/invoices", InvoiceController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Myapp do
  #   pipe_through :api
  # end
end
