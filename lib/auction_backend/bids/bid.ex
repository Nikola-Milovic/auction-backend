defmodule AuctionBackend.Bids.Bid do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuctionBackend.Auctions.Auction
  alias AuctionBackend.Users.User

  schema "bids" do
    field :amount, :integer
    belongs_to :user, User
    belongs_to :auction, Auction
    timestamps()
  end

  @doc false
  def changeset(bid, attrs) do
    bid
    |> cast(attrs, [:amount, :user_id, :auction_id])
    |> validate_required([:amount, :user_id, :auction_id])
    |> assoc_constraint(:auction)
    |> assoc_constraint(:user)
  end
end
