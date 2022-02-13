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

{:ok, date} = Date.new(2022, 6, 5)
{:ok, time} = Time.new(5, 0, 0)

AuctionBackend.Repo.insert!(%AuctionBackend.Item{
  title: "Title1",
  description: "Description 1",
  ends_at: Date.add(date, 3) |> DateTime.new!(time)
})

AuctionBackend.Repo.insert!(%AuctionBackend.Item{
  title: "Title2",
  description: "Description 2",
  ends_at: Date.add(date, 5) |> DateTime.new!(time)
})

AuctionBackend.Repo.insert!(%AuctionBackend.Item{
  title: "Title3",
  description: "Description 3",
  ends_at: Date.add(date, 10) |> DateTime.new!(time)
})
