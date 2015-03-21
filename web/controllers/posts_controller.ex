defmodule Copysshow.PostsController do
  use Copysshow.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "show.html"
  end
end
