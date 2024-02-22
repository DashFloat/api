defmodule DashFloatWeb.Router do
  use DashFloatWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DashFloatWeb do
    pipe_through :api

    get "/dummy", DummyController, :index
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:dash_float, :dev_routes) do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
