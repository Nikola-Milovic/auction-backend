defmodule AuctionBackendGraphql.Schema.ItemTypes do
  use Absinthe.Schema.Notation

  object :item do
    field :id, :id
    field :title, :string
    field :description, :string
    field :ends_at, :date
  end

  scalar :date do
    parse(fn input ->
      case Date.from_iso8601(input.value) do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end)

    serialize(fn date ->
      Date.to_iso8601(date)
    end)
  end
end
