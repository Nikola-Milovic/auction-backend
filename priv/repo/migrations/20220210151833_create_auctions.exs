defmodule AuctionBackend.Repo.Migrations.CreateAuctions do
  use Ecto.Migration

  def change do
    create table (:auctions) do
      add :title, :string, null: false
      add :description, :string, null: false
      add :ends_at, :utc_datetime, null: false
      timestamps()
    end
  end
end
