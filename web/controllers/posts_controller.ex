defmodule Copysshow.PostsController do
  use Copysshow.Web, :controller

  plug :action

  alias Copysshow.Repo
  alias Copysshow.Post

  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    query = from p in Post, limit: 1, order_by: [desc: p.updated_at]
    post = Repo.one query
    render conn, "show.html", post: post
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    Repo.insert %Post{description: params["post"]["description"]}
    redirect conn, to: "/"
  end

end
