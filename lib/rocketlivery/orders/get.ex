defmodule Rocketlivery.Orders.Get do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Order, Repo}

  def by_id(id) do
    case Repo.get(Order, id) do
      nil ->
        ErrorHelper.build_order_not_found_error()
        |> ErrorHelper.wrap()

      order ->
        preloaded_order = Repo.preload(order, :items)

        {:ok, preloaded_order}
    end
  end
end
