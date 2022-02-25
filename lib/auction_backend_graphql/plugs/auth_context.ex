defmodule AuctionBackend.GraphQL.Plug.AuthContext do
  @behaviour Plug
  import Plug.Conn
  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    IO.inspect(context: context)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- AuctionBackend.Authentication.verify(token),
         %{} = user <- get_user(data) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end

  defp get_user(%{id: id}) do
    IO.inspect(id)
    IO.inspect(AuctionBackend.Users.lookup(id))
    AuctionBackend.Users.lookup(id)
  end
end
