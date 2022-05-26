defmodule Rocketlivery.Items.Update do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Item, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Item, id) do
      nil ->
        ErrorHelper.build_item_not_found_error()
        |> ErrorHelper.wrap()

      item ->
        do_update(item, params)
    end
  end

  defp do_update(item, params) do
    item
    |> Item.changeset(params)
    |> Repo.update()
  end
end
