defmodule BackendApi.BurgersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendApi.Burgers` context.
  """

  @doc """
  Generate a burger.
  """
  def burger_fixture(attrs \\ %{}) do
    {:ok, burger} =
      attrs
      |> Enum.into(%{
        ingredients: ["option1", "option2"],
        name: "some name"
      })
      |> BackendApi.Burgers.create_burger()

    burger
  end
end
