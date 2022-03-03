defmodule AuctionBackend.Auctions.Service do
  import Ecto.Query, only: [from: 2]

  @moduledoc """
  AuctionBackend keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias AuctionBackend.Auctions.Auction

  @repo AuctionBackend.Repo

  def list_auctions(args) do
    args
    |> Enum.reduce(Auction, fn
      {_, nil}, query ->
        query

      # {:order, order}, query ->
      #     from q in query, order_by: {^order, :name}
      {:limit, limit}, query ->
        from q in query, limit: ^limit
    end)
    |> @repo.all
  end

  def get_auction(id) do
    @repo.get(Auction, id)
  end

  def get_auction_by(attrs) do
    @repo.get_by(Auction, attrs)
  end

  def insert_auction(attrs, user) do
    user
    |> Ecto.build_assoc(:auctions)
    |> Auction.changeset(attrs)
    |> @repo.insert()
  end

  def delete_auction(%Auction{} = auction), do: @repo.delete(auction)

  def update_auction(%Auction{} = auction, updates) do
    auction
    |> Auction.changeset(updates)
    |> @repo.update()
  end
end
