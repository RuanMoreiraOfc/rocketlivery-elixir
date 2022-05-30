defmodule Rocketlivery.Orders.Create do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.Helpers.ParseItemsParams, as: ParseItemsParamsHelper
  alias Rocketlivery.{Order, Repo}

  def call(params) do
    params
    |> ParseItemsParamsHelper.call()
    |> handle_insert(params)
    |> handle_insert_response()
  end

  defp handle_insert({:error, _reason} = result, _params), do: result

  defp handle_insert({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
  end

  defp handle_insert_response({:error, reason}) do
    reason
    |> ErrorHelper.build_bad_request()
    |> ErrorHelper.wrap()
  end

  defp handle_insert_response({:ok, %Order{}} = result), do: result
end
