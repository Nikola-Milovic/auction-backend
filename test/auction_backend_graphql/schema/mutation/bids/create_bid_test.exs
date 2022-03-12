defmodule AuctionBackend.GraphQL.Schema.Mutation.CreateBidTest do
  use AuctionBackendWeb.ConnCase, async: true
  alias AuctionBackend.Bids.Bid
  alias AuctionBackend.Auctions.Auction

  def auth_user(conn, user) do
    token = AuctionBackend.Authentication.sign(%{id: user.id})
    put_req_cookie(conn, "auction_auth_token", token)
  end

  @query """
  mutation ($input: BidInput!) {
    createBid(input: $input) {
      id
      amount
      auction_id
      user_id
    }
  }

  """
  test "placing a bid with correct values" do
    user = Factory.create_user()

    Factory.populate_user_auctions(user, 1)

    auction = AuctionBackend.Repo.get_by!(Auction, user_id: user.id)

    input = %{
      auction_id: auction.id,
      amount: 500
    }

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
               "createBid" => bid_data
             }
           } = json_response(response, 200)

    assert %{
             "amount" => input.amount,
             "auction_id" => to_string(auction.id),
             "user_id" => to_string(user.id)
           } == Map.drop(bid_data, ["id"])
  end

  test "must be authorized to place a bid" do
    user = Factory.create_user()

    Factory.populate_user_auctions(user, 1)

    auction = AuctionBackend.Repo.get_by!(Auction, user_id: user.id)

    input = %{
      auction_id: auction.id,
      amount: 500
    }

    conn = build_conn()

    response =
      post(conn, "/graphql/v1", %{
        query: @query,
        variables: %{
          input: input
        }
      })

    assert json_response(response, 200) == %{
             "data" => %{"createBid" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "unauthorized",
                 "path" => ["createBid"]
               }
             ]
           }
  end
end
