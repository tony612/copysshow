defmodule Models.WorkTest do
  use ExUnit.Case
  import Ecto.Query

  alias Copysshow.Work
  alias Copysshow.Repo

  setup do
    Ecto.Adapters.SQL.restart_test_transaction(Repo)
    :ok
  end

  test "db operation works" do
    work = %Work{image_url: "http://image.url", type: "original"}
    Repo.insert work

    query = from w in Work, limit: 1
    [fetched] = Repo.all query
    assert %Work{image_url: "http://image.url", type: "original"} = fetched
  end
end
