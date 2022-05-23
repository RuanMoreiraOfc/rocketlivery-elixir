defmodule RocketliveryWeb.FallbackController do
  use RocketliveryWeb, :controller

  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias RocketliveryWeb.ErrorView

  def call(conn, {:error, %ErrorHelper{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
