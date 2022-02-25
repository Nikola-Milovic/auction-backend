defmodule AuctionBackend.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias AuctionBackend.Repo
  alias Comeonin.Ecto.Password
  alias AuctionBackend.Users.User

  @repo AuctionBackend.Repo

  def lookup(id) do
    @repo.get(User, id)
  end

  def authenticate(email, password) do
    user = Repo.get_by(User, email: email)

    with %{password: digest} <- user,
         true <- Password.valid?(password, digest) do
      {:ok, user}
    else
      _ -> :error
    end
  end
end
