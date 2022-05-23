defmodule Rocketlivery.Users.Update do
  alias Ecto.UUID
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Repo, User}

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error ->
        ErrorHelper.build_id_format_error()
        |> ErrorHelper.wrap()

      {:ok, _uuid} ->
        update(params)
    end
  end

  defp update(%{"id" => id} = params) do
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
  end
end
