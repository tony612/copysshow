defmodule Models.PostTest do
  use ExUnit.Case, async: true

  alias Copysshow.Post
  alias Copysshow.Work
  alias Copysshow.Repo

  test "the truth" do
    post = Repo.insert %Post{description: "This is desc."}

    work = Ecto.Model.build(post, :works)
    Repo.insert %Work{work | image_url: "http://image.url", type: "original"}
  end
end
