defmodule Restapp.PageController do
  use Restapp.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
