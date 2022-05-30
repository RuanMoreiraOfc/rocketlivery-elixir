defmodule RocketliveryWeb.OrdersController do
  use RocketliveryWeb, :controller

  alias Rocketlivery.Order
  alias RocketliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Order{} = order} <- Rocketlivery.create_order(params) do
      conn
      |> put_status(:created)
      |> render("create.json", order: order)
    end
  end
end
