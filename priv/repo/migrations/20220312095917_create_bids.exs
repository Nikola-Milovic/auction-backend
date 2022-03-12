defmodule AuctionBackend.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids) do
      add :amount, :integer, null: false
      add :user_id, references(:users, on_delete: :delete_all)
      add :auction_id, references(:auctions, on_delete: :delete_all)

      timestamps()
    end

    create index(:bids, [:user_id])
    create index(:bids, [:auction_id])
    create index(:bids, [:auction_id, :user_id])
  end
end
