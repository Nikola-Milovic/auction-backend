defmodule AuctionBackend.GraphQL.Schema.AuctionTypes do
  use Absinthe.Schema.Notation

  object :auction do
    field :id, :id
    field :user_id, :integer

    field :user, :user do
      resolve(fn auction, _, _ ->
        user =
          AuctionBackend.Users.User
          |> AuctionBackend.Repo.get(auction.user_id)

        {:ok, user}
      end)
    end

    field :title, :string
    field :description, :string
    field :ends_at, :date_time
  end

  scalar :date_time do
    parse(fn input ->
      case DateTime.from_iso8601(input.value) do
        {:ok, datetime, _} -> {:ok, datetime}
        _ -> :error
      end
    end)

    serialize(fn date ->
      DateTime.to_iso8601(date)
    end)
  end
end
