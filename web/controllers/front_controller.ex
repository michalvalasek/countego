defmodule CountEgo.FrontController do
  use CountEgo.Web, :controller

  import Facebook

  def index(conn, _params) do
    counters = Repo.all(CountEgo.Counter)
    render conn, "index.html", counters: counters
  end

  def counter(conn, %{"id" => id}) do
    counter = Repo.get!(CountEgo.Counter, id)

    # get the current likes count
    likes = Facebook.get!(counter.page_id).body[:like_count]

    # update the counter
    counter =
      counter
      |> CountEgo.Counter.changeset(%{likes: likes})
      |> Repo.update!

    render conn, :counter, counter: counter
  end
end
