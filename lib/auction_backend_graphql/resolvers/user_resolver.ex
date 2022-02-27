defmodule AuctionBackend.GraphQL.Resolvers.User do
  alias AuctionBackend.Users

  def login(_, %{email: email, password: password}, _) do
    case Users.authenticate(email, password) do
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

  def me(_, _, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def me(_, _, _) do
    {:ok, nil}
  end
end
