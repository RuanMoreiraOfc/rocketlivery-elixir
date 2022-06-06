defmodule RocketliveryWeb.OrdersControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  import Rocketlivery.Factory

  describe "create/2" do
    test "creates the order via `conn` when all params are valid", %{conn: conn} do
      params = string_params_for(:order_params)

      response =
        conn
        |> post(Routes.orders_path(conn, :create), params)
        |> json_response(:created)

      assert %{"message" => "Order created!", "order" => %{}} = response
    end

    test "fails to create the order via `conn` when any param is invalid", %{conn: conn} do
      params = string_params_for(:order_params, user_id: nil)

      response =
        conn
        |> post(Routes.orders_path(conn, :create), params)
        |> json_response(:bad_request)

      assert %{"message" => %{"user_id" => ["can't be blank"]}} = response
    end
  end

  describe "delete/2" do
    test "deletes the order via `conn` when id has been found", %{conn: conn} do
      id = "4b9eb78b-a91f-4e6c-bda4-01b462f946ff"

      insert(:order, id: id)

      response =
        conn
        |> delete(Routes.orders_path(conn, :delete, id))
        |> json_response(:ok)

      assert %{"order" => %{"id" => ^id}} = response
    end

    test "fails to delete the order via `conn` when id has not been found", %{conn: conn} do
      id = "4b9eb78b-a91f-4e6c-bda4-01b462f946ff"

      response =
        conn
        |> delete(Routes.orders_path(conn, :delete, id))
        |> json_response(:not_found)

      assert %{"message" => "Order not found!"} = response
    end
  end

  describe "show/2" do
    test "shows the order via `conn` when id has been found", %{conn: conn} do
      id = "4b9eb78b-a91f-4e6c-bda4-01b462f946ff"

      insert(:order, id: id)

      response =
        conn
        |> get(Routes.orders_path(conn, :show, id))
        |> json_response(:ok)

      assert %{"order" => %{"id" => ^id}} = response
    end

    test "fails to show the order via `conn` when id has not been found", %{conn: conn} do
      id = "4b9eb78b-a91f-4e6c-bda4-01b462f946ff"

      response =
        conn
        |> get(Routes.orders_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"message" => "Order not found!"} = response
    end
  end

  describe "update/2" do
    test "updates the order via `conn` when id has been found", %{conn: conn} do
      id = "4b9eb78b-a91f-4e6c-bda4-01b462f946ff"

      new_params = %{
        "notes" => "no notes"
      }

      insert(:order, id: id)

      response =
        conn
        |> put(Routes.orders_path(conn, :update, id, new_params))
        |> json_response(:ok)

      assert %{"order" => %{"id" => ^id, "notes" => "no notes"}} = response
    end

    test "fails to update the order via `conn` when id has not been found", %{conn: conn} do
      id = "4b9eb78b-a91f-4e6c-bda4-01b462f946ff"

      new_params = %{
        "notes" => "no notes"
      }

      response =
        conn
        |> put(Routes.orders_path(conn, :update, id, new_params))
        |> json_response(:not_found)

      assert %{"message" => "Order not found!"} = response
    end
  end
end
