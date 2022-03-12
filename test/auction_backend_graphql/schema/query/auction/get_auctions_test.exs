defmodule AuctionBackend.GraphQL.Schema.Queries.GetAuctionsTest do
  use AuctionBackendWeb.ConnCase, async: true

  @query """
  query ($limit: Int!) {
    listAuctions(limit: $limit) {
      id
    }
  }

  """
  test "getting auction with limit" do
    user = Factory.create_user()

    Factory.populate_user_auctions(user, 5)

    conn = build_conn()

    response =
      post(conn, "/graphql/v1", %{
        query: @query,
        variables: %{
          limit: 3
        }
      })

    assert %{
             "data" => %{
               "listAuctions" => auction_data
             }
           } = json_response(response, 200)

    assert 3 == length(auction_data)
  end
end
