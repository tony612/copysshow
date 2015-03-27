defmodule Copysshow.PostsController do
  use Copysshow.Web, :controller

  plug :action

  alias Copysshow.Repo
  alias Copysshow.Post
  alias Copysshow.Work

  import Ecto.Query, only: [from: 2]

  def index(conn, params) do
    page = to_int(params["page"] || 1)
    query = from(p in Post, order_by: [desc: p.updated_at]) |> paginate(page, 1)
    post = Repo.one(query)
    if post, do: post = Repo.preload(post, :works)
    render conn, "show.html", post: post, next_page: page + 1
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    post = Repo.insert %Post{description: params["post"]["description"]}
    Repo.insert %Work{post_id: post.id, type: "original",
                      image_url: params["original"]["image_url"]}
    Repo.insert %Work{post_id: post.id, type: "copy",
                      image_url: params["copy"]["image_url"]}
    redirect conn, to: "/"
  end

  defp to_int(i) when is_integer(i), do: i
  defp to_int(s) when is_binary(s) do
    case Integer.parse(s) do
      {i, _} -> i
      :error -> :error
    end
  end

  defp paginate(query, page \\ 1, size \\ 20) do
    page = page || 1
    size = size || 20
    from query,
      limit: ^size,
      offset: ^((page - 1) * size)
  end

end
