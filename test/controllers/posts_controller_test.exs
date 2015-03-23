defmodule Copysshow.PostsControllerTest do
  use ExUnit.Case, async: false
  use Plug.Test

  alias Copysshow.Repo
  alias Copysshow.Post

  import Ecto.Query

  setup do
    Ecto.Adapters.SQL.restart_test_transaction(Repo)
    :ok
  end

  test ":create creates a post with works" do
    params = %{
      "post"     => %{"description" => "Desc"},
      "original" => %{"image_url"   => "http://original.url"},
      "copy"     => %{"image_url"   => "http://copy.url"}
    }
    response = conn(:post, "/posts", params) |> send_request

    assert response.status == 302
    [post] = Repo.all(Post) |> Repo.preload(:works)
    assert post.description == "Desc"
    work0 = List.first post.works
    work1 = List.last post.works
    assert work0.image_url == "http://original.url"
    assert work0.type == "original"
    assert work1.image_url == "http://copy.url"
    assert work1.type == "copy"
  end

  defp send_request(conn) do
    conn
    |> put_private(:plug_skip_csrf_protection, true)
    |> Copysshow.Endpoint.call([])
  end
end
