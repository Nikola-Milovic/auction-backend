defmodule AuctionBackend.Auctions.Auction do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuctionBackend.Users.User

  schema "auctions" do
    field :title, :string
    field :description, :string
    field :ends_at, :utc_datetime
    belongs_to :user, User
    timestamps()
  end

  def changeset(item, params \\ %{}) do
    item
    |> cast(params, [:title, :description, :ends_at])
    |> validate_required([:title, :description, :ends_at])
    |> validate_length(:title, min: 3)
    |> validate_length(:description, min: 10, max: 200)
    |> validate_change(:ends_at, &validate/2)
  end

  defp validate(:ends_at, ends_at_date) do
    case DateTime.compare(ends_at_date, DateTime.utc_now()) do
      :lt -> [ends_at: "ends_at cannot be in the past"]
      _ -> []
    end
  end
end
