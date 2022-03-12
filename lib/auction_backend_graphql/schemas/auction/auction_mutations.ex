defmodule AuctionBackend.GraphQL.Schema.AuctionMutations do
  use Absinthe.Schema.Notation
  alias AuctionBackend.GraphQL.Resolvers
  alias AuctionBackend.GraphQL.Middleware

  input_object :auction_input do
    field :title, non_null(:string)
    field :description, non_null(:string)
    field :ends_at, non_null(:date_time)
  end

  object :auction_mutations do
    field :create_auction, :auction do
      arg(:input, non_null(:auction_input))
      middleware(Middleware.RequireAuth)
      resolve(&Resolvers.Auction.create_auction/3)
    end
  end
end
