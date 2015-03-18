defmodule Copysshow.Work do
  use Ecto.Model

  schema "works" do
    field :image_url, :string
    field :type, :string

    timestamps
  end
end
