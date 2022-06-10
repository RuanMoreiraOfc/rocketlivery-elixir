defmodule Rocketlivery.Helpers.ParseItemsParams do
  import Ecto.Query

  alias Rocketlivery.{Item, Repo}

  def call(%{"items" => items_from_params}) do
    items_from_params
    |> fetch_items
    |> validate_items
    |> transform_items
  end

  def call(_params), do: {:ok, nil}

  defp fetch_items(items_from_params) do
    items_ids = Enum.map(items_from_params, & &1["id"])

    query = from item in Item, where: item.id in ^items_ids

    items_from_db = Repo.all(query)

    {items_from_params, items_from_db}
  end

  defp validate_items({items_from_params, items_from_db} = items_tuple) do
    ids_count =
      items_from_params
      |> Enum.uniq_by(& &1["id"])
      |> Enum.count()

    ids_from_db_count =
      items_from_db
      |> Enum.uniq_by(& &1.id)
      |> Enum.count()

    is_valid = ids_count == ids_from_db_count

    {is_valid, items_tuple}
  end

  defp transform_items({false, _items_tuple}) do
    {:error, "Invalid ID's!"}
  end

  defp transform_items({true, {items_from_params, items_from_db}}) do
    result =
      items_from_params
      |> Enum.map(fn item ->
        item_from_db = Enum.find(items_from_db, &(&1.id == item["id"]))

        List.duplicate([item_from_db], item["quantity"])
      end)
      |> List.flatten()

    {:ok, result}
  end
end
