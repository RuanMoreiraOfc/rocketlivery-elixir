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

    test "fails to create a changeset when all parmas are invalid" do
      params =
        build(
          :user_params,
          email: "#{String.duplicate("3", 320 - 63 + 1)}@#{String.duplicate("2", 63 - 4)}.111",
          password: "123",
          name: nil,
          age: 17,
          cpf: "000",
          address: nil,
          cep: "123"
        )

      expected_response = %{
        address: ["can't be blank"],
        age: ["must be greater than or equal to 18"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["should be at most 320 character(s)"],
        name: ["can't be blank"],
        password: ["should be at least 8 character(s)"]
      }

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

    test "fails to update a changeset when cpf is invalid" do
      params = build(:user_params)

      new_params = %{
        cpf: "1234567890"
      }

      changeset = User.changeset(params)

      expected_response = %{cpf: ["should be 11 character(s)"]}

      response = User.changeset(changeset, new_params)

      assert errors_on(response) == expected_response
    end
  end
end
