defmodule Rocketlivery.Users.Update do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Repo, User}

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil ->
        ErrorHelper.build_user_not_found_error()
        |> ErrorHelper.wrap()

      user ->
        do_update(user, params)
    end
  end

  defp do_update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
    |> handle_update_response()
  end

  defp handle_update_response({:error, reason}) do
    reason
    |> ErrorHelper.build_bad_request()
    |> ErrorHelper.wrap()
  end

  defp handle_update_response({:ok, %User{}} = result), do: result
end
