defmodule Copysshow.Repo.Migrations.AddPosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :description, :text

      timestamps
    end
  end
end
