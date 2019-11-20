defmodule SafebodaApi.Auth do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    headers = Enum.into(conn.req_headers(), %{})

    SafebodaApi.Services.Auth.check({headers["apikey"], headers["token"]})
    |> IO.inspect()

    # |> send_resp(418, "Hello world")
    conn
  end
end
