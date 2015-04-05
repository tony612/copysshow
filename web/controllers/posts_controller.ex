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
    copy_url = get_image_url("copy", params["copy"])
    original_url = get_image_url("original", params["original"])
    if copy_url && original_url do
      Repo.insert %Work{post_id: post.id, type: "original", image_url: original_url}
      Repo.insert %Work{post_id: post.id, type: "copy", image_url: copy_url}
      redirect conn, to: "/"
    else
      conn
      |> put_status(400)
      |> put_flash(:error, "Can't get url of original or copy")
      |> render "new.html"
    end
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

  defp get_image_url(type, work) when type == "copy" or type == "original" do
    file = work["file"]
    cond do
      work["image_url"] && String.length(work["image_url"]) > 0 -> work["image_url"]
      file && (%Plug.Upload{} = file)  ->
        now = timestamp(:erlang.now)
        put_policy = %Qiniu.PutPolicy{
          scope: "copysshow",
          deadline: div(now, 1_000_000) + div(:timer.minutes(10), 1000)
        }

        res = Qiniu.Uploader.upload put_policy, file.path, key: "#{type}/#{now}_#{file.filename}"
        if res.status_code >= 200 && res.status_code < 300 do
          Path.join(Qiniu.config[:domain], Poison.decode!(res.body)["key"])
        end
      true -> nil
    end
  end

  defp timestamp({mega, sec, micro}) do
    mega * 1_000_000 * 1_000_000 + sec * 1_000_000 + micro
  end

end
