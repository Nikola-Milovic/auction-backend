defmodule AuctionBackend.GraphQL.Schema.UserMutations do
  use Absinthe.Schema.Notation
  alias AuctionBackend.GraphQL.Resolvers

  object :user_mutations do
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:role, non_null(:role))
      resolve(&Resolvers.User.login/3)
    end
  end
end
