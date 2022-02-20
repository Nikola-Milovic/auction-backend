defmodule AuctionBackend.Users do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias AuctionBackend.Repo
  alias Comeonin.Ecto.Password
  alias AuctionBackend.Accounts.User

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
