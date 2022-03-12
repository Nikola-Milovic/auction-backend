defmodule AuctionBackend.GraphQL.Resolvers.Bid do
  alias AuctionBackend.Bids.Service

  @spec create_bid(any, any, any) :: {:ok, any}
  def create_bid(_, %{input: params}, %{context: %{current_user: user}}) do
    case(Service.insert_bid(params, user)) do
      {:error, _} ->
        {:error, "Could not place bid"}

      {:ok, _} = success ->
        success
    end
  end
end
