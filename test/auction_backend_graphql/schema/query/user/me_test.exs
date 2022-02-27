defmodule AuctionBackend.GraphQL.Schema.Query.MeTest do
  use AuctionBackendWeb.ConnCase, async: true

  def auth_user(conn, user) do
    token = AuctionBackend.Authentication.sign(%{id: user.id})
    put_req_header(conn, "authorization", "Bearer #{token}")
  end

  @query """
  query {
    me {
      name
      auctions {
        id
      }
    }
  }
  """
  test "me query will return user data" do
    user = Factory.create_user()
    count = 3
    Factory.populate_user_auctions(user, count)

    conn = build_conn() |> auth_user(user)

    response =
      post(conn, "/graphql/v1", %{
        query: @query
      })

    assert %{
             "data" => %{
               "me" => me
             }
           } = json_response(response, 200)

    assert %{name: user.name} == %{name: me["name"]}
    assert length(me["auctions"]) == count
  end

  test "must be authorized to access me" do
    user = Factory.create_user()
    count = 3
    Factory.populate_user_auctions(user, count)

    conn = build_conn()

    response =
      post(conn, "/graphql/v1", %{
        query: @query
      })

    assert json_response(response, 200) == %{
             "data" => %{"me" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "unauthorized",
                 "path" => ["me"]
               }
             ]
           }
  end
end
