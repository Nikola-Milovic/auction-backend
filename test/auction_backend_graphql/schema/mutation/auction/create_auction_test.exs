defmodule AuctionBackend.GraphQL.Schema.Mutation.CreateAuctionTest do
  use AuctionBackendWeb.ConnCase, async: true

  def auth_user(conn, user) do
    token = AuctionBackend.Authentication.sign(%{id: user.id})
    put_req_cookie(conn, "auction_auth_token", token)
    #    put_req_header(conn, "authorization", "Bearer #{token}")
  end

  @query """
  mutation ($input: AuctionInput!) {
    createAuction(input: $input) {
      id
      title
      description
      endsAt
      user {
        name
        id
      }
    }
  }

  """
  test "creating an auction with correct values" do
    input = %{
      title: "Test Title",
      description: "Test Description",
      endsAt: "2023-03-03T03:00:00.000Z"
    }

    user = Factory.create_user()

    conn = build_conn() |> auth_user(user)

    response =
      post(conn, "/graphql/v1", %{
        query: @query,
        variables: %{
          input: input
        }
      })

    assert %{
             "data" => %{
               "createAuction" => item_data
             }
           } = json_response(response, 200)

    assert %{
             "title" => input.title,
             "description" => input.description,
             "endsAt" => "2023-03-03T03:00:00Z",
             "user" => %{"name" => user.name, "id" => to_string(user.id)}
           } ==
             Map.drop(item_data, ["id"])
  end

  test "must be authorized to create an auction" do
    input = %{
      title: "Test Title",
      description: "Test Description",
      endsAt: "2023-03-03T03:00:00.000Z"
    }

    Factory.create_user()
    conn = build_conn()

    response =
      post(conn, "/graphql/v1", %{
        query: @query,
        variables: %{
          input: input
        }
      })

    assert json_response(response, 200) == %{
             "data" => %{"createAuction" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "unauthorized",
                 "path" => ["createAuction"]
               }
             ]
           }
  end
end
