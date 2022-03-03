defmodule AuctionBackend.GraphQL.Resolvers.User do
  alias AuctionBackend.Users.Service

  def login(_, %{email: email, password: password}, _) do
    case Service.authenticate(email, password) do
      {:ok, user} ->
        token =
          AuctionBackend.Authentication.sign(%{
            id: user.id
          })

        {:ok, %{token: token, user: user}}

      _ ->
        {:error, "incorrect email or password"}
    end
  end

  def check_token(_, %{token: token}, _) do
    with {:ok, %{id: id}} <- AuctionBackend.Authentication.verify(token),
         user <- AuctionBackend.Users.Service.lookup(id) do
      {:ok, user}
    else
      _ -> {:ok, nil}
    end
  end

  def me(_, _, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def me(_, _, _) do
    {:ok, nil}
  end
end
