defmodule AuctionBackend.GraphQL.Schema.UserTypes do
  use Absinthe.Schema.Notation

  object :session do
    field :token, :string
    field :user, :user
  end

  object :user do
    field :id, :id
    field :email, :string
    field :name, :string
    field :money, :integer
    field :auctions, list_of(:auction) do
      resolve fn user, _, _ ->
        import Ecto.Query
        auctions =
        AuctionBackend.Auctions.Auction
        |> where(user_id: ^user.id)
        |> AuctionBackend.Repo.all
        {:ok, auctions}
        end
    end
  end
end
