defmodule RocketliveryWeb.Plugs.UUIDCheckerTest do
  use RocketliveryWeb.ConnCase, async: true

  alias Plug.Conn

  test "returns error to the connection when `id` param is invalid", %{conn: conn} do
    id = "invalid-id"

    response =
      conn
      |> get(Routes.users_path(conn, :show, id))

    assert %Conn{
             halted: true,
             status: 400,
             resp_body: ~s<{"message":"Invalid `id` format!"}>
           } = response
  end
end
