defmodule Copysshow.PostsController do
  use Copysshow.Web, :controller

  plug :action

  alias Copysshow.Repo
  alias Copysshow.Post

  def index(conn, _params) do
    render conn, "show.html"
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    Repo.insert %Post{description: params["post"]["description"]}
    redirect conn, to: "/"
  end

end
