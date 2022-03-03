defmodule AuctionBackend.GraphQL.Schema.UserMutations do
  use Absinthe.Schema.Notation
  alias AuctionBackend.GraphQL.Resolvers

  object :user_mutations do
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.User.login/3)
    end

    field :check_token, :user do
      arg(:token, non_null(:string))
      resolve(&Resolvers.User.check_token/3)
    end

  end
end
