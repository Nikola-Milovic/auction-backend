defmodule AuctionBackendGraphql.Resolver.Item do
  def list_items(_, args, _) do
    {:ok, AuctionBackend.list_items(args)}
  end
end
