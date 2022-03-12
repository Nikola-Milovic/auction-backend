defmodule AuctionBackend.GraphQL.Schema.UserQueries do
  use Absinthe.Schema.Notation
  alias AuctionBackend.GraphQL.{Resolvers, Middleware}

  object :user_queries do
    field :me, :user do
      middleware(Middleware.RequireAuth)
      resolve(&Resolvers.User.me/3)
    end
  end
end
