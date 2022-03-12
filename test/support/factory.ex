defmodule Factory do
  alias AuctionBackend.{Repo, Auctions, Users}
  alias Ecto

  def create_user() do
    int = :erlang.unique_integer([:positive, :monotonic])

    params = %{
      name: "Person #{int}",
      email: "fake-#{int}@example.com",
      password: "super-secret",
      money: 1000
    }

    %Users.User{}
    |> Users.User.changeset(params)
    |> Repo.insert!()
  end

  def populate_user_auctions(user) do
    populate_user_auctions(user, 3)
  end

  def populate_user_auctions(user, amount) do
    {:ok, date} = Date.new(2022, 6, 5)
    {:ok, time} = Time.new(5, 0, 0)

    1..amount
    |> Enum.each(&create_auction(user, &1, date, time))
  end

  defp create_auction(user, id, date, time) do
    user
    |> Ecto.build_assoc(:auctions, %{
      title: "Title" <> to_string(id),
      description: "Description" <> to_string(id),
      ends_at: Date.add(date, id * 2) |> DateTime.new!(time)
    })
    |> Auctions.Auction.changeset()
    |> Repo.insert()
  end
end
