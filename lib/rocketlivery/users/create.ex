defmodule Rocketlivery.Users.Create do
  alias Rocketlivery.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert_response()
  end

  defp handle_insert_response({:ok, %User{}} = result), do: result

  defp handle_insert_response({:error, result}) do
    {:error, %{status: :bad_request, result: result}}
  end
end
