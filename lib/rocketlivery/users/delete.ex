defmodule Rocketlivery.Users.Delete do
  alias Ecto.UUID
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Repo, User}

  def call(id) do
    case UUID.cast(id) do
      :error ->
        ErrorHelper.build_id_format_error()
        |> ErrorHelper.wrap()

      {:ok, uuid} ->
        delete(uuid)
    end
  end

  defp delete(id) do
    case Repo.get(User, id) do
      nil ->
        ErrorHelper.build_user_not_found_error()
        |> ErrorHelper.wrap()

      user ->
        Repo.delete(user)
    end
  end
end
