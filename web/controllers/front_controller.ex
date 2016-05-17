defmodule CountEgo.FrontController do
  use CountEgo.Web, :controller

  def index(conn, _params) do
    counters = Repo.all(CountEgo.Counter)
    render conn, "index.html", counters: counters
  end

  def counter(conn, %{"id" => id}) do
    counter = Repo.get!(CountEgo.Counter, id)
    render conn, :counter, counter: counter
  end
end
