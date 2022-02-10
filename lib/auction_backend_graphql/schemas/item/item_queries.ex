defmodule AuctionBackendGraphql.Schema.ItemQueries do
  use Absinthe.Schema.Notation
  alias AuctionBackendGraphql.Resolver

  object :item_queries do
    field :list_items, list_of(:item) do
      resolve(&Resolver.Item.list_items/3)
    end
  end
end
