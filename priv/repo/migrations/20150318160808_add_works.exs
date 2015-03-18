defmodule Copysshow.Repo.Migrations.AddWorks do
  use Ecto.Migration

  def change do
    create table(:works) do
      add :image_url, :string
      add :type, :string

      timestamps
    end
  end
end
