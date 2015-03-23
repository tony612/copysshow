defmodule Models.PostTest do
  use ExUnit.Case

  alias Copysshow.Post
  alias Copysshow.Work
  alias Copysshow.Repo

  setup do
    Ecto.Adapters.SQL.restart_test_transaction(Repo)
    :ok
  end

  test "db operation works" do
    post = Repo.insert %Post{description: "This is desc."}

    work = Ecto.Model.build(post, :works)
    Repo.insert %Work{work | image_url: "http://image.url", type: "original"}
  end
end
