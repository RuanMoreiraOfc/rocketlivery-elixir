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

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Rocketlivery.delete_user(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Rocketlivery.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end
end
