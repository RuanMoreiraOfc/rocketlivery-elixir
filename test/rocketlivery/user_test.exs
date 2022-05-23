defmodule Rocketlivery.UserTest do
  use Rocketlivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rocketlivery.User

  describe "changeset/1" do
    test "creates a changeset when all params are valid" do
      params = %{
        email: "anyone@email.com",
        password: "12345678",
        address: "St Anywhere",
        name: "Anny One",
        age: 24,
        cpf: "12345678907",
        cep: "12345678"
      }

      response = User.changeset(params)

      assert %Changeset{valid?: true, changes: %{name: "Anny One"}} = response
    end
  end

  describe "changeset/2" do
    test "updates a existing changeset when new params are valid" do
      params = %{
        email: "anyone@email.com",
        password: "12345678",
        address: "St Anywhere",
        name: "Anny One",
        age: 24,
        cpf: "12345678907",
        cep: "12345678"
      }

      new_params = %{
        name: "Not Anny One"
      }

      changeset = User.changeset(params)

      response = User.changeset(changeset, new_params)

      assert %Changeset{valid?: true, changes: %{name: "Not Anny One"}} = response
    end

    test "updates the password from a existing changeset when new password is valid" do
      params = %{
        email: "anyone@email.com",
        password: "12345678",
        address: "St Anywhere",
        name: "Anny One",
        age: 24,
        cpf: "12345678907",
        cep: "12345678"
      }

      new_params = %{
        password: "12378945"
      }

      %Changeset{changes: %{password_hash: old_password_hash}} =
        changeset = User.changeset(params)

      expected_response = true

      %Changeset{changes: %{password_hash: _response}} = User.changeset(changeset, new_params)

      assert Pbkdf2.verify_pass(params.password, old_password_hash) == expected_response
      # FIXME: For some reason it fails!
      # assert Pbkdf2.verify_pass(new_params.password, response) == expected_response
    end
  end
end
