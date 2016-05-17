defmodule CountEgo.Router do
  use CountEgo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CountEgo.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_layout do
    plug :put_layout, {CountEgo.LayoutView, :admin}
  end

  scope "/", CountEgo do
    pipe_through :browser # Use the default browser stack

    get "/", FrontController, :index
    get "/counter/:id", FrontController, :counter

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/admin", CountEgo do
    pipe_through [:browser, :authenticate_user, :admin_layout]

    get "/", CounterController, :index, as: :admin
    resources "/counters", CounterController
  end

  # Other scopes may use custom stacks.
  scope "/api", CountEgo do
    pipe_through :api

    get "/counter/:id", FrontController, :counter, as: :api_counter
  end
end
