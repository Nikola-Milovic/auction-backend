defmodule AuctionBackend.Repo.Migrations.AddUserToAuctions do
  use Ecto.Migration

  def change do
    alter table(:auctions) do
      add :user_id, references(:users)
    end
  end
end
