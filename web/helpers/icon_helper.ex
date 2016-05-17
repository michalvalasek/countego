defmodule IconHelper do
  use Phoenix.HTML

  def icon(name, prepend: text) do
    [text, " ", icon(name)]
  end
  def icon(name, append: text) do
    [icon(name), " ", text]
  end
  def icon(name) do
    content_tag :i, "", class: "fa fa-#{name}"
  end
end
