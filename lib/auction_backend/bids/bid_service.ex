defmodule AuctionBackend.Bids.Service do
  @moduledoc """
  The Bids context.
  """

  import Ecto.Query, warn: false
  alias AuctionBackend.Repo
  alias AuctionBackend.Bids.Bid

  @repo Repo

  def insert_bid(attrs, user) do
    user
    |> Ecto.build_assoc(:bids)
    |> Bid.changeset(attrs)
    |> @repo.insert()
  end
end
