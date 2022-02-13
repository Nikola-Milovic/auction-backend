defmodule AuctionBackendGraphQl.Resolvers.Item do
  def list_items(_, args, _) do
    {:ok, AuctionBackend.list_items(args)}
  end

  @spec popular_items(any, any, any) :: {:ok, any}
  def popular_items(_, args, _) do
    {:ok, AuctionBackend.list_items(args)}
  end

  @spec create_item(any, any, any) :: {:ok, any}
  def create_item(_, %{input: params}, _) do
    case(AuctionBackend.insert_item(params)) do
      {:error, _} ->
        {:error, "Could not create auction"}

      {:ok, _} = success ->
        success
    end
  end
end
