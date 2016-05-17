defmodule CountEgo.CounterTest do
  use CountEgo.ModelCase

  alias CountEgo.Counter

  @valid_attrs %{likes: 42, name: "some content", page_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Counter.changeset(%Counter{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Counter.changeset(%Counter{}, @invalid_attrs)
    refute changeset.valid?
  end
end
