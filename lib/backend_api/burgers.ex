defmodule BackendApi.Burgers do
  @moduledoc """
  The Burgers context.
  """

  import Ecto.Query, warn: false
  alias BackendApi.Repo

  alias BackendApi.Burgers.Burger

  @doc """
  Returns the list of burgers.

  ## Examples

      iex> list_burgers()
      [%Burger{}, ...]

  """
  def list_burgers do
    Repo.all(Burger)
  end

  @doc """
  Gets a single burger.

  Raises `Ecto.NoResultsError` if the Burger does not exist.

  ## Examples

      iex> get_burger!(123)
      %Burger{}

      iex> get_burger!(456)
      ** (Ecto.NoResultsError)

  """
  def get_burger!(id), do: Repo.get!(Burger, id)

  @doc """
  Creates a burger.

  ## Examples

      iex> create_burger(%{field: value})
      {:ok, %Burger{}}

      iex> create_burger(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_burger(attrs \\ %{}) do
    %Burger{}
    |> Burger.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a burger.

  ## Examples

      iex> update_burger(burger, %{field: new_value})
      {:ok, %Burger{}}

      iex> update_burger(burger, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_burger(%Burger{} = burger, attrs) do
    burger
    |> Burger.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a burger.

  ## Examples

      iex> delete_burger(burger)
      {:ok, %Burger{}}

      iex> delete_burger(burger)
      {:error, %Ecto.Changeset{}}

  """
  def delete_burger(%Burger{} = burger) do
    Repo.delete(burger)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking burger changes.

  ## Examples

      iex> change_burger(burger)
      %Ecto.Changeset{data: %Burger{}}

  """
  def change_burger(%Burger{} = burger, attrs \\ %{}) do
    Burger.changeset(burger, attrs)
  end
end
