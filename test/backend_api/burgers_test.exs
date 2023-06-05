defmodule BackendApi.BurgersTest do
  use BackendApi.DataCase

  alias BackendApi.Burgers

  describe "burgers" do
    alias BackendApi.Burgers.Burger

    import BackendApi.BurgersFixtures

    @invalid_attrs %{ingredients: nil, name: nil}

    test "list_burgers/0 returns all burgers" do
      burger = burger_fixture()
      assert Burgers.list_burgers() == [burger]
    end

    test "get_burger!/1 returns the burger with given id" do
      burger = burger_fixture()
      assert Burgers.get_burger!(burger.id) == burger
    end

    test "create_burger/1 with valid data creates a burger" do
      valid_attrs = %{ingredients: ["option1", "option2"], name: "some name"}

      assert {:ok, %Burger{} = burger} = Burgers.create_burger(valid_attrs)
      assert burger.ingredients == ["option1", "option2"]
      assert burger.name == "some name"
    end

    test "create_burger/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Burgers.create_burger(@invalid_attrs)
    end

    test "update_burger/2 with valid data updates the burger" do
      burger = burger_fixture()
      update_attrs = %{ingredients: ["option1"], name: "some updated name"}

      assert {:ok, %Burger{} = burger} = Burgers.update_burger(burger, update_attrs)
      assert burger.ingredients == ["option1"]
      assert burger.name == "some updated name"
    end

    test "update_burger/2 with invalid data returns error changeset" do
      burger = burger_fixture()
      assert {:error, %Ecto.Changeset{}} = Burgers.update_burger(burger, @invalid_attrs)
      assert burger == Burgers.get_burger!(burger.id)
    end

    test "delete_burger/1 deletes the burger" do
      burger = burger_fixture()
      assert {:ok, %Burger{}} = Burgers.delete_burger(burger)
      assert_raise Ecto.NoResultsError, fn -> Burgers.get_burger!(burger.id) end
    end

    test "change_burger/1 returns a burger changeset" do
      burger = burger_fixture()
      assert %Ecto.Changeset{} = Burgers.change_burger(burger)
    end
  end
end
