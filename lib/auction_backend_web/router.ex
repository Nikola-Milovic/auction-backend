defmodule AuctionBackendWeb.Router do
  use AuctionBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  pipeline :graphql do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_cookies
    plug CORSPlug
    plug AuctionBackend.GraphQL.Plug.Session
    plug AuctionBackend.GraphQL.Plug.AuthContext
  end

  scope "/api", AuctionBackendWeb do
    pipe_through :api
  end

  scope "/graphql/v1" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: AuctionBackend.GraphQL.Schema
    # before_send: {AuctionBackend.GraphQL.Plug.AuthContext, :absinthe_before_send}
  end

  if Mix.env() == :dev do
    scope "/graphiql" do
      pipe_through :graphql

      forward "/", Absinthe.Plug.GraphiQL, schema: AuctionBackend.GraphQL.Schema
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AuctionBackendWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
