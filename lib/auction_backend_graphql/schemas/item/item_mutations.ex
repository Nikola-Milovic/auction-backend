defmodule AuctionBackendGraphQl.Schema.ItemMutations do
  use Absinthe.Schema.Notation
  alias AuctionBackendGraphQl.Resolvers

  input_object :menu_item_input do
    field :title, non_null(:string)
    field :description, non_null(:string)
    field :ends_at, non_null(:date_time)
  end

  object :item_mutations do
    field :create_auction_item, :item do
      arg(:input, non_null(:menu_item_input))
      resolve(&Resolvers.Item.create_item/3)
    end
  end
end
