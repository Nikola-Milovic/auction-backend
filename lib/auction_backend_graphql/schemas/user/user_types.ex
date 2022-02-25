defmodule AuctionBackend.GraphQL.Schema.UserTypes do
  use Absinthe.Schema.Notation

  object :session do
    field :token, :string
    field :user, :user
  end

  object :user do
    field :email, :string
    field :name, :string
    field :money, :integer
    field :auctions, list_of(:auction)
  end
end
