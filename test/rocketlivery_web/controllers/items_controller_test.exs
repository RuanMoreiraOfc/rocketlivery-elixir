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
end
