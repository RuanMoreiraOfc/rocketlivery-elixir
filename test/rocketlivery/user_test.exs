defmodule Rocketlivery.UserTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Ecto.Changeset
  alias Rocketlivery.User

  describe "changeset/1" do
    test "creates a changeset when all params are valid" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{valid?: true, changes: %{name: "Anny One"}} = response
    end

    test "fails to create a changeset when email is in invalid format" do
      params = build(:user_params, email: "invalid-email")

      expected_response = %{email: ["has invalid format"]}

      response = User.changeset(params)

      assert errors_on(response) == expected_response
    end
  end

  describe "changeset/2" do
    test "updates a existing changeset when new params are valid" do
      params = build(:user_params)

      new_params = %{
        name: "Not Anny One"
      }

      changeset = User.changeset(params)

      response = User.changeset(changeset, new_params)

      assert %Changeset{valid?: true, changes: %{name: "Not Anny One"}} = response
    end

    test "updates the password from a existing changeset when new password is valid" do
      params = build(:user_params)

      new_params = %{
        # From web always come as `key => value` notation
        "password" => "12378945"
      }

      %Changeset{changes: %{password_hash: old_password_hash}} =
        changeset = User.changeset(params)

      expected_response = true

      %Changeset{changes: %{password_hash: response}} = User.changeset(changeset, new_params)

      assert Pbkdf2.verify_pass(params.password, old_password_hash) == expected_response
      assert Pbkdf2.verify_pass(new_params["password"], response) == expected_response
    end
  end
end
