defmodule AuctionBackend.Items do
  import Ecto.Query, only: [from: 2]

  @moduledoc """
  AuctionBackend keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias AuctionBackend.Item

  @repo AuctionBackend.Repo

  def list_items(args) do
    args
    |> Enum.reduce(Item, fn
      {_, nil}, query ->
        query

      # {:order, order}, query ->
      #     from q in query, order_by: {^order, :name}
      {:limit, limit}, query ->
        from q in query, limit: ^limit
    end)
    |> @repo.all
  end

  def get_item(id) do
    @repo.get(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def insert_item(attrs) do
    %AuctionBackend.Item{}
    |> Item.changeset(attrs)
    |> @repo.insert()
  end

  def delete_item(%AuctionBackend.Item{} = item), do: @repo.delete(item)

  def update_item(%AuctionBackend.Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> @repo.update()
  end
end
