defmodule AuctionBackend.GraphQL.Plug.AuthContext do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- AuctionBackend.Authentication.verify(token),
         %{} = user <- get_user(data) do
      %{current_user: user, auth_token: token}
    else
      _ -> %{}
    end
  end

  defp get_user(%{id: id}) do
    AuctionBackend.Users.Service.lookup(id)
  end

  # def absinthe_before_send(conn, %Absinthe.Blueprint{} = blueprint) do
  #   if auth_token = blueprint.execution.context[:auth_token] do
  #     put_resp_cookie(conn, "auth_token", %{token: auth_token}, sign: true)
  #   else
  #     conn
  #   end
  # end

  # def absinthe_before_send(conn, _) do
  #   conn
  # end
end

defmodule AuctionBackend.GraphQL.Plug.AuthContext do
  @behaviour Plug
  import Plug.Conn
  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with data <- get_session(conn, :user_id),
         %{} = user <- get_user(data) do
      %{current_user: user}
    else
      _ -> %{guest: true}
    end
  end

  defp get_user(id) when is_number(id) do
    AuctionBackend.Users.Service.lookup(id)
  end

  defp get_user(nil), do: nil
end
