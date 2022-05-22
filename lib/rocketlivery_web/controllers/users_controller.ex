defmodule RocketliveryWeb.UsersController do
  use RocketliveryWeb, :controller

  alias Rocketlivery.User
  alias RocketliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketlivery.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
