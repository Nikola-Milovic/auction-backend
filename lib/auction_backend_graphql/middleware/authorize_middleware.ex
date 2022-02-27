defmodule AuctionBackend.GraphQL.Middleware.Authorize do
  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    with %{current_user: _} <- resolution.context do
      resolution
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unauthorized"})
    end
  end
end
