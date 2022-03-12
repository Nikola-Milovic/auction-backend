defmodule AuctionBackend.Repo.Migrations.AddBidsToUsersAndAuctions do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :bids, references(:bids)
    end
    
    alter table(:auctions) do
      add :bids, references(:bids)
    end
  end
end
