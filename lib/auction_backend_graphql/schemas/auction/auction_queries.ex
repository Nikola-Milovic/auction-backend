defmodule AuctionBackend.GraphQL.Schema.AuctionQueries do
  use Absinthe.Schema.Notation
  alias AuctionBackend.GraphQL.Resolvers

  object :auction_queries do
    field :list_auctions, list_of(:auction) do
      arg(:limit, :integer)
      resolve(&Resolvers.Auction.list_auctions/3)
    end

    field :popular_auctions, list_of(:auction) do
      resolve(&Resolvers.Auction.popular_auctions/3)
    end

    field :auction_details, :auction do
      arg(:id, non_null(:integer))
      resolve(&Resolvers.Auction.auction_details/3)
    end
  end
end
