# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AuctionBackend.Repo.insert!(%AuctionBackend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias AuctionBackend.{Repo, Auctions, Users}

{:ok, date} = Date.new(2022, 6, 5)
{:ok, time} = Time.new(5, 0, 0)

user =
  Users.User.changeset(%Users.User{}, %{
    name: "Test user",
    email: "test@gmail.com",
    money: 1000,
    password: "123qwe"
  })
  |> Repo.insert!()

user2 =
  Users.User.changeset(%Users.User{}, %{
    name: "Test user2",
    email: "test2@gmail.com",
    money: 1000,
    password: "123qwe"
  })
  |> Repo.insert!()

# user = AuctionBackend.Repo.get!(AuctionBackend.Users.User, 1)

user
|> Ecto.build_assoc(:auctions, %{
  title: "Title1",
  description: "Description 1",
  ends_at: Date.add(date, 3) |> DateTime.new!(time)
})
|> Auctions.Auction.changeset()
|> Repo.insert!()

user2
|> Ecto.build_assoc(:auctions, %{
  title: "Title2",
  description: "Description 2",
  ends_at: Date.add(date, 5) |> DateTime.new!(time)
})
|> Auctions.Auction.changeset()
|> Repo.insert!()

user
|> Ecto.build_assoc(:auctions, %{
  title: "Title3",
  description: "Description 3",
  ends_at: Date.add(date, 7) |> DateTime.new!(time)
})
|> Auctions.Auction.changeset()
|> Repo.insert!()
