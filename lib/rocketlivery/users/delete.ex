defmodule Rocketlivery.Users.Delete do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.{Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      nil ->
        ErrorHelper.build_user_not_found_error()
        |> ErrorHelper.wrap()

      user ->
        Repo.delete(user)
    end
  end
end
