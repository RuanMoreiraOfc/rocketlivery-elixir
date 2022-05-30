defmodule Rocketlivery.Orders.Update do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.Helpers.ParseItemsParams, as: ParseItemsParamsHelper
  alias Rocketlivery.{Order, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Order, id) do
      nil ->
        ErrorHelper.build_order_not_found_error()
        |> ErrorHelper.wrap()

      order ->
        order
        |> Repo.preload(:items)
        |> do_update(params)
    end
  end

  defp do_update(oldOrder, params) do
    params
    |> ParseItemsParamsHelper.call()
    |> handle_update(oldOrder, params)
    |> handle_update_response
  end

  defp handle_update({:error, _reason} = result, _oldOrder, _params), do: result

  defp handle_update({:ok, items}, oldOrder, params) do
    clean_update_result =
      oldOrder
      |> Order.changeset(params, [])
      # IT HAS NO UNIQUE ID PER LINE, WHEN TRY TO UPDATE IT FAILS, SO CLEAR IT FIRST
      |> Repo.update()

    case clean_update_result do
      {:ok, cleaned_order} ->
        handle_update({:next, items}, cleaned_order, params)

      _ ->
        handle_update(clean_update_result, nil, nil)
    end
  end

  defp handle_update({:next, items}, cleanedOrder, params) do
    filtered_items = if is_nil(items), do: cleanedOrder.items, else: items

    cleanedOrder
    |> Order.changeset(params, filtered_items)
    |> Repo.update()
  end

  defp handle_update_response({:error, reason}) do
    reason
    |> ErrorHelper.build_bad_request()
    |> ErrorHelper.wrap()
  end

  defp handle_update_response({:ok, %Order{}} = result), do: result
end
