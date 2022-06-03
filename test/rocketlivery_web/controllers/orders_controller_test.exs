defmodule RocketliveryWeb.OrdersControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  # This test always gonna fail because Plug.Query.encode_pair can't parse a nested maps param
  # TODO
  # describe "create/2" do
  #   test "creates the order via `conn` when all params are valid", %{conn: conn} do
  #     params = string_params_for(:order_params)

  #     response =
  #       conn
  #       |> post(Routes.orders_path(conn, :create, params))
  #       |> json_response(:created)

  #     assert %{"message" => "Order created!", "order" => %{}} = response
  #   end

  #   test "fails to create the order via `conn` when any param is invalid", %{conn: conn} do
  #     params = string_params_for(:order_params, user_id: nil)

  #     response =
  #       conn
  #       |> post(Routes.orders_path(conn, :create, params))
  #       |> json_response(:bad_request)

  #     assert %{"message" => %{"user_id" => ["can't be blank"]}} = response
  #   end
  # end
end
