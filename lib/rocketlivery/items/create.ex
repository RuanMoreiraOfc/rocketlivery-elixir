defmodule Rocketlivery.Items.Create do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Item, Repo}

  def call(params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_insert_response()
  end

  defp handle_insert_response({:ok, %Item{}} = result), do: result

  defp handle_insert_response({:error, result}) do
    result
    |> ErrorHelper.build_bad_request()
    |> ErrorHelper.wrap()
  end
end
