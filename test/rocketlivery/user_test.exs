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
end
