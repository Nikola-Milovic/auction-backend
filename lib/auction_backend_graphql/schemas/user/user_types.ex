defmodule AuctionBackend.GraphQL.Schema.UserTypes do
  use Absinthe.Schema.Notation

  object :session do
    field :token, :string
    field :user, :user
  end

  interface :user do
    field :email, :string
    field :name, :string
    field :auctions, list_of(:item)
  end

end
