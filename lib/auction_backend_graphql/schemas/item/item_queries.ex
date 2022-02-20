defmodule AuctionBackend.GraphQL.Schema.ItemQueries do
  use Absinthe.Schema.Notation
  alias AuctionBackend.GraphQL.Resolvers

  object :item_queries do
    field :list_items, list_of(:item) do
      arg(:limit, :integer)
      resolve(&Resolvers.Item.list_items/3)
    end

    field :popular_items, list_of(:item) do
      resolve(&Resolvers.Item.popular_items/3)
    end

    field :item_details, :item do
      arg(:id, non_null(:integer))
      resolve(&Resolvers.Item.item_details/3)
    end
  end
end
