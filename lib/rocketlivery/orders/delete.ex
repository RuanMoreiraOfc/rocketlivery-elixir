defmodule Rocketlivery.Orders.Delete do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Order, Repo}

  def call(id) do
    case Repo.get(Order, id) do
      nil ->
        ErrorHelper.build_order_not_found_error()
        |> ErrorHelper.wrap()

      order ->
        order
        |> Repo.preload(:items)
        |> Repo.delete()
    end
  end
end
