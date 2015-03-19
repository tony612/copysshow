defmodule Copysshow.Post do
  use Ecto.Model

  alias Copysshow.Work

  schema "posts" do
    field :description, :string

    has_many :works, Work

    timestamps
  end
end
