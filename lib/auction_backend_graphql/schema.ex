defmodule AuctionBackend.GraphQL.Schema do
  use Absinthe.Schema

  # alias AuctionBackend.GraphQL.Middleware.{SafeResolution, ErrorHandler}

  import_types(__MODULE__.AuctionTypes)
  import_types(__MODULE__.AuctionQueries)
  import_types(__MODULE__.AuctionMutations)

  import_types(__MODULE__.UserMutations)
  import_types(__MODULE__.UserTypes)
  import_types(__MODULE__.UserQueries)

  query do
    import_fields(:auction_queries)
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:auction_mutations)
    import_fields(:user_mutations)
  end

  # def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation] do
  #   SafeResolution.apply(middleware) ++ [ErrorHandler]
  # end

  # def middleware(middleware, _field, _object) do
  #   middleware
  # end
end
