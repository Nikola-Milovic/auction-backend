defmodule AuctionBackend.GraphQL.Schema.BidMutations do
  use Absinthe.Schema.Notation
  alias AuctionBackend.GraphQL.Resolvers
  alias AuctionBackend.GraphQL.Middleware

  input_object :bid_input do
    field :amount, non_null(:integer)
    field :auction_id, non_null(:id)
  end

  object :bid_mutations do
    field :create_bid, :bid do
      arg(:input, non_null(:bid_input))
      middleware(Middleware.RequireAuth)
      resolve(&Resolvers.Bid.create_bid/3)
    end
  end
end
