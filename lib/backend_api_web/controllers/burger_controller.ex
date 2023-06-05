defmodule BackendApiWeb.BurgerController do
  use BackendApiWeb, :controller

  alias BackendApi.Burgers
  alias BackendApi.Burgers.Burger

  action_fallback BackendApiWeb.FallbackController

  def index(conn, _params) do
    burgers = Burgers.list_burgers()
    render(conn, :index, burgers: burgers)
  end

  def create(conn, %{"burger" => burger_params}) do
    with {:ok, %Burger{} = burger} <- Burgers.create_burger(burger_params) do
      conn
      |> put_status(:created)
      |> render(:show, burger: burger)
    end
  end

  def show(conn, %{"id" => id}) do
    burger = Burgers.get_burger!(id)
    render(conn, :show, burger: burger)
  end

  def update(conn, %{"id" => id, "burger" => burger_params}) do
    burger = Burgers.get_burger!(id)

    with {:ok, %Burger{} = burger} <- Burgers.update_burger(burger, burger_params) do
      render(conn, :show, burger: burger)
    end
  end

  def delete(conn, %{"id" => id}) do
    burger = Burgers.get_burger!(id)

    with {:ok, %Burger{}} <- Burgers.delete_burger(burger) do
      send_resp(conn, :no_content, "")
    end
  end
end
