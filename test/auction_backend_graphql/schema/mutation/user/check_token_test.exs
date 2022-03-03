defmodule AuctionBackend.GraphQL.Schema.Mutation.CheckTokenTest do
  use AuctionBackendWeb.ConnCase, async: true

  @query """
  mutation ($token: String!) {
   checkToken( token:$token) {
      name,
      money
    }
  }
  """
  test "checking token with a valid token will return user" do
    user = Factory.create_user()

    token = AuctionBackend.Authentication.sign(%{id: user.id})

    response =
      post(build_conn(), "/graphql/v1", %{
        query: @query,
        variables: %{"token" => token}
      })

    assert %{
             "data" => %{
               "checkToken" => user_data
             }
           } = json_response(response, 200)

    assert %{"name" => user.name, "money" => user.money} == user_data
  end

  test "checking token with expired token will return nil" do
    user = Factory.create_user()

    user_salt = "user salt"

    token =
      Phoenix.Token.sign(AuctionBackendWeb.Endpoint, user_salt, %{id: user.id}, signed_at: 0)

    response =
      post(build_conn(), "/graphql/v1", %{
        query: @query,
        variables: %{"token" => token}
      })

    assert %{
             "data" => %{
               "checkToken" => user_data
             }
           } = json_response(response, 200)

    assert nil == user_data
  end

  test "checking token with invalid token will return nil" do
    Factory.create_user()

    token = "some invalid token"

    response =
      post(build_conn(), "/graphql/v1", %{
        query: @query,
        variables: %{"token" => token}
      })

    assert %{
             "data" => %{
               "checkToken" => user_data
             }
           } = json_response(response, 200)

    assert nil == user_data
  end
end
