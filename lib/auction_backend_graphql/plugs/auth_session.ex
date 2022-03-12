defmodule AuctionBackend.GraphQL.Plug.Session do
  @behaviour Plug
  import Plug.Conn
  def init(opts), do: opts

  def call(conn, _) do
    check_if_auth(conn)
    #  |> IO.inspect()
  end

  defp check_if_auth(conn) do
    with token <- conn.req_cookies["auction_auth_token"],
         {:ok, %{id: id}} <- AuctionBackend.Authentication.verify(token) do
      put_session(conn, :user_id, id)
    else
      _ -> put_session(conn, :guest, true)
    end
  end
end
