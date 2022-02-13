defmodule AuctionBackendGraphQl.Schema.ItemQueries do
  use Absinthe.Schema.Notation
  alias AuctionBackendGraphQl.Resolvers

  object :item_queries do
    field :list_items, list_of(:item) do
      arg(:limit, :integer)
      resolve(&Resolvers.Item.list_items/3)
    end

    field :popular_items, list_of(:item) do
      resolve(&Resolvers.Item.popular_items/3)
    end
  end
end
