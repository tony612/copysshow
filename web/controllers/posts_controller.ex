defmodule Copysshow.PostsController do
  use Copysshow.Web, :controller

  plug :action

  alias Copysshow.Repo
  alias Copysshow.Post
  alias Copysshow.Work

  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    query = from p in Post, limit: 1, order_by: [desc: p.updated_at]
    post = Repo.one(query) |> Repo.preload(:works)
    render conn, "show.html", post: post
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

end
