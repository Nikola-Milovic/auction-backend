defmodule AuctionBackendGraphql.Schema do
  use Absinthe.Schema

  import_types(__MODULE__.ItemTypes)

  query do
    import_fields(:item_queries)
  end
end
