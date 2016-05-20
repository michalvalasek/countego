require IEx

defmodule Facebook do
  use HTTPoison.Base

  @expected_fields ~w(
    url normalized_url share_count like_count comment_count total_count click_count comments_fbid commentsbox_count
  )

  def process_url(page_id) do
    "http://api.facebook.com/restserver.php?method=links.getStats&urls=https://www.facebook.com/#{page_id}&format=json"
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.at(0)
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
