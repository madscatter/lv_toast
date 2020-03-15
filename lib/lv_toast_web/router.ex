defmodule LvToastWeb.Router do
#  use LvToastWeb, :router
  use Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LvToastWeb do
    pipe_through :browser

#    get "/page", PageController, :index
    live "/", ToastLive

  end
end
