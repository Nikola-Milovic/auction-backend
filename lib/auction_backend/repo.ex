defmodule AuctionBackend.Repo do
  use Ecto.Repo,
    otp_app: :auction_backend,
    adapter: Ecto.Adapters.Postgres
end
