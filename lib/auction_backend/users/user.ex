defmodule AuctionBackend.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuctionBackend.Auctions.Auction
  alias AuctionBackend.Bids.Bid

  schema "users" do
    field :email, :string
    field :money, :integer
    field :name, :string
    field :password, Comeonin.Ecto.Password
    has_many :auctions, Auction
    has_many :bids, Bid

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :money])
    |> validate_required([:name, :email, :password, :money])
    |> unique_constraint(:email)
  end
end
