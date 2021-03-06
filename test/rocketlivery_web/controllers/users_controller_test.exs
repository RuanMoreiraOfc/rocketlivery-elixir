defmodule RocketliveryWeb.UsersControllerTest do
  use RocketliveryWeb.ConnCase, async: true

  import Mox
  import Rocketlivery.Factory

  alias Rocketlivery.ViaCep.{ClientMock, Response}
  alias RocketliveryWeb.Auth.Guardian

  @existing_id "b815baa2-f7a4-4eeb-ad2b-2790d48cbbf3"
  @non_existing_id "c815baa2-f7a4-4eeb-ad2b-2790d48cbbf3"

  defp setup_authenticated_route(%{conn: conn}) do
    {:ok, token, _claims} =
      :user
      |> insert(id: @existing_id)
      |> Guardian.encode_and_sign()

    authenticated_conn = put_req_header(conn, "authorization", "Bearer #{token}")

    {:ok, authenticated_conn: authenticated_conn, unauthenticated_conn: conn}
  end

  describe "create/2" do
    test "creates the user via `conn` when all params are valid", %{conn: conn} do
      params = string_params_for(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        response = struct!(Response, build(:user_cep_info))

        {:ok, response}
      end)

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
    setup [:setup_authenticated_route]

    test "deletes the user via `conn` when id has been found", %{
      authenticated_conn: authenticated_conn
    } do
      response =
        authenticated_conn
        |> delete(Routes.users_path(authenticated_conn, :delete, @existing_id))
        |> json_response(:ok)

      assert %{"user" => %{"id" => @existing_id}} = response
    end

    test "fails to delete the user via `conn` when id has not been found", %{
      authenticated_conn: authenticated_conn
    } do
      response =
        authenticated_conn
        |> delete(Routes.users_path(authenticated_conn, :delete, @non_existing_id))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end

    test "fails to delete the user via `conn` when request is unauthenticated", %{
      unauthenticated_conn: unauthenticated_conn
    } do
      response =
        unauthenticated_conn
        |> delete(Routes.users_path(unauthenticated_conn, :delete, @existing_id))
        |> json_response(:unauthorized)

      assert %{"message" => "unauthenticated"} = response
    end

    test "fails to delete the user via `conn` when request is unauthenticated and id not exists",
         %{
           unauthenticated_conn: unauthenticated_conn
         } do
      response =
        unauthenticated_conn
        |> delete(Routes.users_path(unauthenticated_conn, :delete, @non_existing_id))
        |> json_response(:unauthorized)

      assert %{"message" => "unauthenticated"} = response
    end
  end

  describe "show/2" do
    setup [:setup_authenticated_route]

    test "shows the user via `conn` when id has been found", %{
      authenticated_conn: authenticated_conn
    } do
      response =
        authenticated_conn
        |> get(Routes.users_path(authenticated_conn, :show, @existing_id))
        |> json_response(:ok)

      assert %{"user" => %{"id" => @existing_id}} = response
    end

    test "fails to show the user via `conn` when id has not been found", %{
      authenticated_conn: authenticated_conn
    } do
      response =
        authenticated_conn
        |> get(Routes.users_path(authenticated_conn, :show, @non_existing_id))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end

    test "fails to show the user via `conn` when request is unauthenticated", %{
      unauthenticated_conn: unauthenticated_conn
    } do
      response =
        unauthenticated_conn
        |> get(Routes.users_path(unauthenticated_conn, :show, @existing_id))
        |> json_response(:unauthorized)

      assert %{"message" => "unauthenticated"} = response
    end

    test "fails to show the user via `conn` when request is unauthenticated and id not exists",
         %{
           unauthenticated_conn: unauthenticated_conn
         } do
      response =
        unauthenticated_conn
        |> get(Routes.users_path(unauthenticated_conn, :show, @non_existing_id))
        |> json_response(:unauthorized)

      assert %{"message" => "unauthenticated"} = response
    end
  end

  describe "sign_in/2" do
    test "signs in the user via `conn` when id has been found", %{conn: conn} do
      params = string_params_for(:user_sign_in_params)

      response =
        conn
        |> post(Routes.users_path(conn, :sign_in, params))
        |> json_response(:ok)

      assert %{"token" => _token} = response
    end

    test "fails to signs in the user via `conn` when id has not been found", %{conn: conn} do
      params = string_params_for(:user_sign_in_params, id: @non_existing_id)

      response =
        conn
        |> post(Routes.users_path(conn, :sign_in, params))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end

    test "fails to signs in the user via `conn` when password is wrong", %{conn: conn} do
      params = string_params_for(:user_sign_in_params, password: "87654321")

      response =
        conn
        |> post(Routes.users_path(conn, :sign_in, params))
        |> json_response(:unauthorized)

      assert %{"message" => "Please verify your credentials!"} = response
    end

    test "fails to signs in the user via `conn` when any param is missing", %{conn: conn} do
      params =
        :user_sign_in_params
        |> string_params_for()
        |> Map.drop(["id"])

      response =
        conn
        |> post(Routes.users_path(conn, :sign_in, params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid or missing params"} = response
    end
  end

  describe "update/2" do
    setup [:setup_authenticated_route]

    test "updates the user via `conn` when id has been found", %{
      authenticated_conn: authenticated_conn
    } do
      new_params = %{
        "age" => 84
      }

      response =
        authenticated_conn
        |> put(Routes.users_path(authenticated_conn, :update, @existing_id, new_params))
        |> json_response(:ok)

      assert %{"user" => %{"id" => @existing_id, "age" => 84}} = response
    end

    test "fails to update the user via `conn` when id has not been found", %{
      authenticated_conn: authenticated_conn
    } do
      new_params = %{
        "age" => 84
      }

      response =
        authenticated_conn
        |> put(Routes.users_path(authenticated_conn, :update, @non_existing_id, new_params))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end

    test "fails to update the user via `conn` when request is unauthenticated", %{
      unauthenticated_conn: unauthenticated_conn
    } do
      new_params = %{
        "age" => 84
      }

      response =
        unauthenticated_conn
        |> put(Routes.users_path(unauthenticated_conn, :update, @existing_id, new_params))
        |> json_response(:unauthorized)

      assert %{"message" => "unauthenticated"} = response
    end

    test "fails to update the user via `conn` when request is unauthenticated and id not exists",
         %{
           unauthenticated_conn: unauthenticated_conn
         } do
      new_params = %{
        "age" => 84
      }

      response =
        unauthenticated_conn
        |> put(Routes.users_path(unauthenticated_conn, :update, @non_existing_id, new_params))
        |> json_response(:unauthorized)

      assert %{"message" => "unauthenticated"} = response
    end
  end
end
