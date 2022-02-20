defmodule AuctionBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :money, :integer

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
