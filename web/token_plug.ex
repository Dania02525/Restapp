defmodule PlugToken do
  import Plug.Conn

  def init(opts) do
    secret = Application.get_env(:joken, :secret_key)
    json_module = Application.get_env(:joken, :json_module)
    claims = Keyword.get(opts, :claims, %{})
    algorithm = Application.get_env(:joken, :algorithm, :HS256)

    {secret, json_module, algorithm, claims}
  end

  def call(conn, config) do
    parse_auth(conn, get_req_header(conn, "token"), config)
  end

  defp parse_auth(conn, [token], {secret, json_module, algorithm, claims}) do
    case Joken.Token.decode(secret, json_module, token, algorithm, claims) do
      {:error, error} ->
        create_401_response(conn, error, json_module)
      {:ok, payload} ->
        conn |> assign(:claims, payload)      
    end
  end

  defp parse_auth(conn, _, {_secret, json_module, _algorithm, _claims}) do
    create_401_response(conn, "Unauthorized", json_module)
  end

  defp create_401_response(conn, description, json_module) do
    json = json_module.encode(%{error: "Unauthorized", description: description, status_code: 401})
    send_resp(conn, 401, json) |> halt
  end
end