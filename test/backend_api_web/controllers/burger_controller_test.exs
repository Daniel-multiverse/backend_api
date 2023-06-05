defmodule BackendApiWeb.BurgerControllerTest do
  use BackendApiWeb.ConnCase

  import BackendApi.BurgersFixtures

  alias BackendApi.Burgers.Burger

  @create_attrs %{
    ingredients: ["option1", "option2"],
    name: "some name"
  }
  @update_attrs %{
    ingredients: ["option1"],
    name: "some updated name"
  }
  @invalid_attrs %{ingredients: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all burgers", %{conn: conn} do
      conn = get(conn, ~p"/api/burgers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create burger" do
    test "renders burger when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/burgers", burger: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/burgers/#{id}")

      assert %{
               "id" => ^id,
               "ingredients" => ["option1", "option2"],
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/burgers", burger: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update burger" do
    setup [:create_burger]

    test "renders burger when data is valid", %{conn: conn, burger: %Burger{id: id} = burger} do
      conn = put(conn, ~p"/api/burgers/#{burger}", burger: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/burgers/#{id}")

      assert %{
               "id" => ^id,
               "ingredients" => ["option1"],
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, burger: burger} do
      conn = put(conn, ~p"/api/burgers/#{burger}", burger: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete burger" do
    setup [:create_burger]

    test "deletes chosen burger", %{conn: conn, burger: burger} do
      conn = delete(conn, ~p"/api/burgers/#{burger}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/burgers/#{burger}")
      end
    end
  end

  defp create_burger(_) do
    burger = burger_fixture()
    %{burger: burger}
  end
end
