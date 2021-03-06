defmodule Copysshow.Work do
  use Ecto.Model

  schema "works" do
    field :image_url, :string
    field :type, :string # original, copy

    belongs_to :post, Copysshow.Post

    timestamps
  end
end
