defmodule CountEgo.CounterControllerTest do
  use CountEgo.ConnCase

  alias CountEgo.Counter
  @valid_attrs %{likes: 42, name: "some content", page_id: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, counter_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing counters"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, counter_path(conn, :new)
    assert html_response(conn, 200) =~ "New counter"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, counter_path(conn, :create), counter: @valid_attrs
    assert redirected_to(conn) == counter_path(conn, :index)
    assert Repo.get_by(Counter, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, counter_path(conn, :create), counter: @invalid_attrs
    assert html_response(conn, 200) =~ "New counter"
  end

  test "shows chosen resource", %{conn: conn} do
    counter = Repo.insert! %Counter{}
    conn = get conn, counter_path(conn, :show, counter)
    assert html_response(conn, 200) =~ "Show counter"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, counter_path(conn, :show, "11111111-1111-1111-1111-111111111111")
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    counter = Repo.insert! %Counter{}
    conn = get conn, counter_path(conn, :edit, counter)
    assert html_response(conn, 200) =~ "Edit counter"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    counter = Repo.insert! %Counter{}
    conn = put conn, counter_path(conn, :update, counter), counter: @valid_attrs
    assert redirected_to(conn) == counter_path(conn, :show, counter)
    assert Repo.get_by(Counter, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    counter = Repo.insert! %Counter{}
    conn = put conn, counter_path(conn, :update, counter), counter: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit counter"
  end

  test "deletes chosen resource", %{conn: conn} do
    counter = Repo.insert! %Counter{}
    conn = delete conn, counter_path(conn, :delete, counter)
    assert redirected_to(conn) == counter_path(conn, :index)
    refute Repo.get(Counter, counter.id)
  end
end
