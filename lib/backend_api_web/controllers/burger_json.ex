defmodule BackendApiWeb.BurgerJSON do
  alias BackendApi.Burgers.Burger

  @doc """
  Renders a list of burgers.
  """
  def index(%{burgers: burgers}) do
    %{data: for(burger <- burgers, do: data(burger))}
  end

  @doc """
  Renders a single burger.
  """
  def show(%{burger: burger}) do
    %{data: data(burger)}
  end

  defp data(%Burger{} = burger) do
    %{
      id: burger.id,
      name: burger.name,
      ingredients: burger.ingredients
    }
  end
end
