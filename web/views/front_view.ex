defmodule CountEgo.FrontView do
  use CountEgo.Web, :view

  def render("counter.json", %{counter: counter}) do
    %{name: counter.name, likes: counter.likes}
  end
end
