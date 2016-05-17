defmodule CountEgo.CounterController do
  use CountEgo.Web, :controller
  
  alias CountEgo.Counter

  plug :scrub_params, "counter" when action in [:create, :update]

  def index(conn, _params) do
    counters = Repo.all(Counter)
    render(conn, "index.html", counters: counters)
  end

  def new(conn, _params) do
    changeset = Counter.changeset(%Counter{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"counter" => counter_params}) do
    changeset = Counter.changeset(%Counter{}, counter_params)

    case Repo.insert(changeset) do
      {:ok, _counter} ->
        conn
        |> put_flash(:info, "Counter created successfully.")
        |> redirect(to: counter_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    counter = Repo.get!(Counter, id)
    render(conn, "show.html", counter: counter)
  end

  def edit(conn, %{"id" => id}) do
    counter = Repo.get!(Counter, id)
    changeset = Counter.changeset(counter)
    render(conn, "edit.html", counter: counter, changeset: changeset)
  end

  def update(conn, %{"id" => id, "counter" => counter_params}) do
    counter = Repo.get!(Counter, id)
    changeset = Counter.changeset(counter, counter_params)

    case Repo.update(changeset) do
      {:ok, counter} ->
        conn
        |> put_flash(:info, "Counter updated successfully.")
        |> redirect(to: counter_path(conn, :show, counter))
      {:error, changeset} ->
        render(conn, "edit.html", counter: counter, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    counter = Repo.get!(Counter, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(counter)

    conn
    |> put_flash(:info, "Counter deleted successfully.")
    |> redirect(to: counter_path(conn, :index))
  end
end
