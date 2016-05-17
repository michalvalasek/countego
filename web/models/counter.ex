defmodule CountEgo.Counter do
  use CountEgo.Web, :model

  schema "counters" do
    field :name, :string
    field :page_id, :string
    field :likes, :integer, default: 0

    timestamps
  end

  @required_fields ~w(name page_id likes)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:page_id)
  end
end
