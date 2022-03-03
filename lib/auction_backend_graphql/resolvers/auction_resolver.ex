defmodule AuctionBackend.GraphQL.Resolvers.Auction do
  alias AuctionBackend.Auctions.Service
  def list_auctions(_, args, _) do
    {:ok, Service.list_auctions(args)}
  end

  @spec popular_auctions(any, any, any) :: {:ok, any}
  def popular_auctions(_, args, _) do
    {:ok, Service.list_auctions(args)}
  end

  @spec create_auction(any, any, any) :: {:ok, any}
  def create_auction(_, %{input: params}, %{context: %{current_user: user}}) do
    case(Service.insert_auction(params, user)) do
      {:error, _} ->
        {:error, "Could not create auction"}

      {:ok, _} = success ->
        success
    end
  end

  @spec auction_details(any, %{:id => any, optional(any) => any}, any) :: {:ok}
  def auction_details(_, %{id: id}, _) do
    case Service.get_auction(id) do
      %{id: _} = item -> {:ok, item}
      nil -> {:error, "No auction matching that ID"}
    end
  end
end
