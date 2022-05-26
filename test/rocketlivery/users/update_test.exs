defmodule Rocketlivery.Users.UpdateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Ecto.Changeset
  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.User
  alias Rocketlivery.Users.Update

  describe "call/1" do
    test "updates an user in database when all params are valid" do
      %{id: id} = insert(:user)
      new_params = %{"id" => id, "age" => 200}

      response = Update.call(new_params)

      assert {:ok, %User{id: ^id, age: 200}} = response
    end

    test "fails to update an user in database when any param is invalid" do
      %{id: id} = insert(:user)
      new_params = %{"id" => id, "age" => 17}

      response = Update.call(new_params)

      assert {:error, %Changeset{errors: _errors}} = response
    end

    test "fails to update an user in database when id is invalid" do
      %{id: id_from_database} = insert(:user)
      id = String.replace(id_from_database, ~r/.$/, &if(&1 == "0", do: "1", else: "0"))
      new_params = %{"id" => id}

      response = Update.call(new_params)

      assert {:error, %Error{status: :not_found, result: _result}} = response
    end
  end
end
