defmodule RocketliveryWeb.Auth.Guardian do
  use Guardian, otp_app: :rocketlivery

  alias Rocketlivery.User
  alias Rocketlivery.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end
end
