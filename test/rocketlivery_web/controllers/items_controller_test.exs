defmodule RocketliveryWeb.ItemsControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  import Rocketlivery.Factory

  describe "create/2" do
    test "creates the item via `conn` when all params are valid", %{conn: conn} do
      params = string_params_for(:item_params)

      response =
        conn
        |> post(Routes.items_path(conn, :create, params))
        |> json_response(:created)

      assert %{"message" => "Item created!", "item" => %{}} = response
    end

    test "fails to create the item via `conn` when any param is invalid", %{conn: conn} do
      params = string_params_for(:item_params, category: "any")

      response =
        conn
        |> post(Routes.items_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "category" => ["is invalid, valid options are: ['food', 'drink', 'desert']"]
               }
             } = response
    end
  end

  describe "delete/2" do
    test "deletes the item via `conn` when id has been found", %{conn: conn} do
      id = "7c6576f9-9161-4bba-8b94-d997c6d0f4a1"

      insert(:item, id: id)

      response =
        conn
        |> delete(Routes.items_path(conn, :delete, id))
        |> json_response(:ok)

      assert %{"item" => %{"id" => ^id}} = response
    end

    test "fails to delete the item via `conn` when id has not been found", %{conn: conn} do
      id = "7c6576f9-9161-4bba-8b94-d997c6d0f4a1"

      response =
        conn
        |> delete(Routes.items_path(conn, :delete, id))
        |> json_response(:not_found)

      assert %{"message" => "Item not found!"} = response
    end
  end

  describe "show/2" do
    test "shows the item via `conn` when id has been found", %{conn: conn} do
      id = "7c6576f9-9161-4bba-8b94-d997c6d0f4a1"

      insert(:item, id: id)

      response =
        conn
        |> get(Routes.items_path(conn, :show, id))
        |> json_response(:ok)

      assert %{"item" => %{"id" => ^id}} = response
    end

    test "fails to show the item via `conn` when id has not been found", %{conn: conn} do
      id = "7c6576f9-9161-4bba-8b94-d997c6d0f4a1"

      response =
        conn
        |> get(Routes.items_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"message" => "Item not found!"} = response
    end
  end
end
