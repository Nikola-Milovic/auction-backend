defmodule Factory do
  def create_user() do
    int = :erlang.unique_integer([:positive, :monotonic])

    params = %{
      name: "Person #{int}",
      email: "fake-#{int}@example.com",
      password: "super-secret",
      money: 1000
    }

    %AuctionBackend.Users.User{}
    |> AuctionBackend.Users.User.changeset(params)
    |> AuctionBackend.Repo.insert!()
  end
end
