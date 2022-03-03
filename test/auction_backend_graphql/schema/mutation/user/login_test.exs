defmodule AuctionBackend.GraphQL.Schema.Mutation.LoginTest do
  use AuctionBackendWeb.ConnCase, async: true

  @query """
  mutation ($email: String!) {
   login( email:$email,password:"super-secret") {
     token
     user { name, money }
    }
  }
  """
  test "creating an user session" do
    user = Factory.create_user()

    response =
      post(build_conn(), "/graphql/v1", %{
        query: @query,
        variables: %{"email" => user.email}
      })

    assert %{
             "data" => %{
               "login" => %{
                 "token" => token,
                 "user" => user_data
               }
             }
           } = json_response(response, 200)

    # IO.inspect(response)

    assert %{"name" => user.name, "money" => user.money} == user_data

    assert {:ok, %{id: user.id}} ==
             AuctionBackend.Authentication.verify(token)
  end
end
