defmodule AuctionBackend.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :money, :integer
    field :name, :string
    field :password, Comeonin.Ecto.Password

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :money])
    |> validate_required([:name, :email, :password, :money])
  end
end
