defmodule Rocketlivery.Users.Get do
  alias Ecto.UUID
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Repo, User}

  def by_id(id) do
    case UUID.cast(id) do
      :error ->
        ErrorHelper.build_id_format_error()
        |> ErrorHelper.wrap()

      {:ok, uuid} ->
        get(uuid)
    end
  end

  defp get(id) do
    case Repo.get(User, id) do
      nil ->
        ErrorHelper.build_user_not_found_error()
        |> ErrorHelper.wrap()

      user ->
        {:ok, user}
    end
  end
end
