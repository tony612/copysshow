defmodule Models.WorkTest do
  use ExUnit.Case, async: true
  import Ecto.Query

  alias Copysshow.Work
  alias Copysshow.Repo

  test "db operation works" do
    work = %Work{image_url: "http://image.url", type: "original"}
    Repo.insert work

    query = from w in Work, limit: 1
    [fetched] = Repo.all query
    assert %Work{image_url: "http://image.url", type: "original"} = fetched
  end
end
