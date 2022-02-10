defmodule AuctionBackend do
  @moduledoc """
  AuctionBackend keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias AuctionBackend.Item

  @repo AuctionBackend.Repo

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def insert_item(attrs) do
    AuctionBackend.Item
    |> struct(attrs)
    |> @repo.insert()
  end

  def delete_item(%AuctionBackend.Item{} = item), do: @repo.delete(item)

  def update_item(%AuctionBackend.Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> @repo.update()
  end
end
