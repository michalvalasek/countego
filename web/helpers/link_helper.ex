defmodule LinkHelper do
  use Phoenix.HTML

  def active_path?(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    path == current_path
  end

  def active_class(conn, path) do
    if active_path?(conn, path), do: "active", else: ""
  end

  def navigation_item(conn, text, path) do
    active_class = active_class(conn, path)
    link = link text, to: path, class: active_class
    content_tag :li, link, class: active_class, role: "navigation"
  end
end
