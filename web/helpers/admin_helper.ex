defmodule AdminHelper do
  use Phoenix.HTML
  import IconHelper, only: [icon: 2]

  def page_header(title) do
    content_tag :h1, title, class: "page-header"
  end

  def sub_header(title) do
    content_tag :h2, title, class: "sub-header"
  end

  def nav_button(path, text, opts \\ []) do
    class = opts |> Keyword.get(:class, "default")
    label = case opts[:icon] do
      icon_name ->
        icon(icon_name, append: text)
      _ ->
        text
    end
    link label, to: path, class: "btn btn-#{class} pull-right"
  end

  def form_actions(f, back_path \\ nil) do
    sbmt = submit "Save", class: "btn btn-primary"
    br = tag :br
    back = if back_path, do: link("Cancel", to: back_path), else: ""
    content_tag :div, [sbmt, br, back], class: "actions"
  end

  def badge(text) do
    content_tag :span, text, class: "badge"
  end

  def table(cols, content, opts \\ []) do
    thead = content_tag :thead, content_tag(:tr, Enum.map(cols, fn col -> content_tag(:th, col) end))
    tbody = content_tag :tbody, content
    table_class = Keyword.get(opts, :class, "table-striped table-hover")
    table = content_tag :table, [thead, tbody], class: "table #{table_class}", id: Keyword.get(opts, :id, "")
    content_tag :div, table, class: "table-responsive"
  end

  def preview_table(rows) do
    rows = Enum.map(rows, fn {label, val} -> preview_table_row(label, val) end)
    table [], rows, class: "table-responsive"
  end

  def preview_table_row(label, value) do
    content_tag :tr, [
      content_tag(:td, content_tag(:strong, label)),
      content_tag(:td, value)
    ]
  end
end
