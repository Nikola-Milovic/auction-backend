defmodule AuctionBackend.Authentication do
  @user_salt "user salt"
  def sign(data) do
    Phoenix.Token.sign(AuctionBackendWeb.Endpoint, @user_salt, data)
  end

  def verify(token) do
    # TODO change max age
    Phoenix.Token.verify(AuctionBackendWeb.Endpoint, @user_salt, token, max_age: 600)
  end
end
