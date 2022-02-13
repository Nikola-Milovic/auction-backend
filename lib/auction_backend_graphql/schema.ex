defmodule AuctionBackendGraphQl.Schema do
  use Absinthe.Schema

  import_types(__MODULE__.ItemTypes)
  import_types(__MODULE__.ItemQueries)
  import_types(__MODULE__.ItemMutations)

  query do
    import_fields(:item_queries)
  end

  mutation do
    import_fields(:item_mutations)
  end
end
