defmodule Copysshow.Repo.Migrations.AddPostIdToWorks do
  use Ecto.Migration

  def change do
    alter table(:works) do
      add :post_id, references(:posts)
    end
  end
end
