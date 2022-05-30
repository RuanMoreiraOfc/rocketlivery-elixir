defmodule Rocketlivery.Orders.Create do
  import Ecto.Query

  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Item, Order, Repo}

  def call(params) do
    params
    |> fetch_items()
    |> validate_items()
    |> transform_items()
    |> handle_insert(params)
    |> handle_insert_response()
  end

  defp fetch_items(%{"items" => itemsFromParams}) do
    items_ids = Enum.map(itemsFromParams, & &1["id"])

    query = from item in Item, where: item.id in ^items_ids

    items_from_db = Repo.all(query)

    {itemsFromParams, items_from_db}
  end

  defp validate_items({itemsFromParams, itemsFromDB} = itemsTuple) do
    ids_count =
      itemsFromParams
      |> Enum.uniq_by(& &1["id"])
      |> Enum.count()

    ids_from_db_count =
      itemsFromDB
      |> Enum.uniq_by(& &1.id)
      |> Enum.count()

    is_valid = ids_count == ids_from_db_count

    {is_valid, itemsTuple}
  end

  defp transform_items({false, _itemsTuple}) do
    {:error, "Invalid ID's!"}
  end

  defp transform_items({true, {itemsFromParams, itemsFromDB}}) do
    result =
      itemsFromParams
      |> Enum.map(fn item ->
        item_from_db = Enum.find(itemsFromDB, &(&1.id == item["id"]))

        List.duplicate([item_from_db], item["quantity"])
      end)
      |> List.flatten()

    {:ok, result}
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
