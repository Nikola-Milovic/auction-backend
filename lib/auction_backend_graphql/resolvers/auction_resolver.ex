defmodule AuctionBackend.GraphQL.Resolvers.Auction do
  alias AuctionBackend.Auctions
  def list_auctions(_, args, _) do
    {:ok, Auctions.list_auctions(args)}
  end

  @spec popular_auctions(any, any, any) :: {:ok, any}
  def popular_auctions(_, args, _) do
    {:ok, Auctions.list_auctions(args)}
  end

  @spec create_auction(any, any, any) :: {:ok, any}
  def create_auction(_, %{input: params}, _) do
    case(Auctions.insert_auction(params)) do
      {:error, _} ->
        {:error, "Could not create auction"}

      {:ok, _} = success ->
        success
    end
  end

  @spec auction_details(any, %{:id => any, optional(any) => any}, any) :: {:ok}
  def auction_details(_, %{id: id}, _) do
    case Auctions.get_auction(id) do
      %{id: _} = item -> {:ok, item}
      nil -> {:error, "No auction matching that ID"}
    end
  end
end
