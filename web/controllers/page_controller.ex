defmodule Copysshow.PageController do
  use Copysshow.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
