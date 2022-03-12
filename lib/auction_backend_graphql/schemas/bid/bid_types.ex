defmodule AuctionBackend.GraphQL.Schema.BidTypes do
  use Absinthe.Schema.Notation

  object :bid do
    field :id, :id
    field :amount, :integer
    field :user_id, :id
    field :auction_id, :id

    field :user, :user do
      resolve(fn bid, _, _ ->
        user =
          AuctionBackend.Users.User
          |> AuctionBackend.Repo.get(bid.user_id)

        {:ok, user}
      end)
    end

    field :auction, :auction do
      resolve(fn bid, _, _ ->
        auction =
          AuctionBackend.Auctions.Auction
          |> AuctionBackend.Repo.get(bid.auction_id)

        {:ok, auction}
      end)
    end

    field :created_at, :date_time
  end
end
