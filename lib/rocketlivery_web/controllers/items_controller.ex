defmodule RocketliveryWeb.ItemsController do
  use RocketliveryWeb, :controller

  alias Rocketlivery.Item
  alias RocketliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Item{} = item} <- Rocketlivery.create_item(params) do
      conn
      |> put_status(:created)
      |> render("create.json", item: item)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Item{} = item} <- Rocketlivery.delete_item(id) do
      conn
      |> put_status(:ok)
      |> render("item.json", item: item)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Item{} = item} <- Rocketlivery.get_item_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("item.json", item: item)
    end
  end
end
