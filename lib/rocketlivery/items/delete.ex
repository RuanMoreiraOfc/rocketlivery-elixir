defmodule Rocketlivery.Items.Delete do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Item, Repo}

  def call(id) do
    case Repo.get(Item, id) do
      nil ->
        ErrorHelper.build_item_not_found_error()
        |> ErrorHelper.wrap()

      item ->
        Repo.delete(item)
    end
  end
end
