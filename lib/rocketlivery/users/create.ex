defmodule Rocketlivery.Users.Create do
  alias Rocketlivery.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
