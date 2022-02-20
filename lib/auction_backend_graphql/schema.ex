defmodule AuctionBackend.GraphQL.Schema do
  use Absinthe.Schema

  #alias AuctionBackend.GraphQL.Middleware.{SafeResolution, ErrorHandler}

  import_types(__MODULE__.ItemTypes)
  import_types(__MODULE__.ItemQueries)
  import_types(__MODULE__.ItemMutations)

  import_types(__MODULE__.UserMutations)
  import_types(__MODULE__.UserTypes)

  query do
    import_fields(:item_queries)
  end

  mutation do
    import_fields(:item_mutations)
    import_fields(:user_mutations)
  end

  # def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation] do
  #   SafeResolution.apply(middleware) ++ [ErrorHandler]
  # end

  # def middleware(middleware, _field, _object) do
  #   middleware
  # end
end
