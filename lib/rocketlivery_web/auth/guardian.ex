defmodule RocketliveryWeb.Auth.Guardian do
  use Guardian, otp_app: :rocketlivery

  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.User
  alias Rocketlivery.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end

  def authenticate(%{"id" => id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false ->
        "Please verify your credentials!"
        |> ErrorHelper.build_unauthorized()
        |> ErrorHelper.wrap()

      error ->
        error
    end
  end

  def authenticate(_) do
    "Invalid or missing params"
    |> ErrorHelper.build_bad_request()
    |> ErrorHelper.wrap()
  end
end
