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
end
