defmodule Rocketlivery.Users.Get do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Repo, User}

  def by_id(id) do
    case Repo.get(User, id) do
      nil ->
        ErrorHelper.build_user_not_found_error()
        |> ErrorHelper.wrap()

      user ->
        {:ok, user}
    end
  end
end
