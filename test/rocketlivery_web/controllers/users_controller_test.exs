defmodule RocketliveryWeb.UsersControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  import Rocketlivery.Factory

  describe "create/2" do
    test "creates the user via `conn` when all params are valid", %{conn: conn} do
      params = string_params_for(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{"message" => "User created!", "user" => %{}} = response
    end

    test "fails to create the user via `conn` when any param is invalid", %{conn: conn} do
      params = string_params_for(:user_params, age: 17)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"age" => ["must be greater than or equal to 18"]}} = response
    end
  end

  describe "delete/2" do
    test "deletes the user via `conn` when id has been found", %{conn: conn} do
      id = "b815baa2-f7a4-4eeb-ad2b-2790d48cbbf3"

      insert(:user, id: id)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:ok)

      assert %{"user" => %{"id" => ^id}} = response
    end
  end
end
