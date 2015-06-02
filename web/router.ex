defmodule Restapp.Router do
  use Phoenix.Router

  pipeline :user do
    plug :accepts, ["json"]
    plug PlugToken, claims: %{aud: "user"}
    plug Plug.Parsers, parsers: [ :json],
                       pass: ["application/json"],
                       json_decoder: Poison
  end

  pipeline :guest do
    plug :accepts, ["json"]
    plug Plug.Parsers, parsers: [ :json],
                       pass: ["application/json"],
                       json_decoder: Poison
  end

  scope "/api", Restapp do
    pipe_through :user 
    resources "/invoices", InvoiceController
  end

  scope "/login", Restapp do
    pipe_through :guest
    post "/", LoginController, :login_user
  end

  # Other scopes may use custom stacks.
  # scope "/api", Myapp do
  #   pipe_through :api
  # end
end
