defmodule BackendApi.Repo.Migrations.CreateBurgers do
  use Ecto.Migration

  def change do
    create table(:burgers) do
      add :name, :string
      add :ingredients, {:array, :string}

      timestamps()
    end
  end
end
