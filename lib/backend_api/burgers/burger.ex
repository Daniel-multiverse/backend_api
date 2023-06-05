defmodule BackendApi.Burgers.Burger do
  use Ecto.Schema
  import Ecto.Changeset

  schema "burgers" do
    field :ingredients, {:array, :string}
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(burger, attrs) do
    burger
    |> cast(attrs, [:name, :ingredients])
    |> validate_required([:name, :ingredients])
  end
end
