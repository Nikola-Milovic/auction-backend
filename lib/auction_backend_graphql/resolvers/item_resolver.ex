defmodule AuctionBackend.GraphQL.Resolvers.Item do
  alias AuctionBackend.Items
  def list_items(_, args, _) do
    {:ok, Items.list_items(args)}
  end

  @spec popular_items(any, any, any) :: {:ok, any}
  def popular_items(_, args, _) do
    {:ok, Items.list_items(args)}
  end

  @spec create_item(any, any, any) :: {:ok, any}
  def create_item(_, %{input: params}, _) do
    case(Items.insert_item(params)) do
      {:error, _} ->
        {:error, "Could not create auction"}

      {:ok, _} = success ->
        success
    end
  end

  @spec item_details(any, %{:input => any, optional(any) => any}, any) ::
          {:error, <<_::184>>} | {:ok, any}
  @spec item_details(any, %{:id => any, optional(any) => any}, any) :: {:ok}
  def item_details(_, %{id: id}, _) do
    case Items.get_item(id) do
      %{id: _} = item -> {:ok, item}
      nil -> {:error, "No item matching that ID"}
    end
  end
end
