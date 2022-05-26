defmodule Rocketlivery.Items.Get do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Item, Repo}

  def by_id(id) do
    case Repo.get(Item, id) do
      nil ->
        ErrorHelper.build_item_not_found_error()
        |> ErrorHelper.wrap()

      item ->
        {:ok, item}
    end
  end
end
