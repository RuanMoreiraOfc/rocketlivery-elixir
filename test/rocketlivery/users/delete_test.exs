defmodule Rocketlivery.Users.DeleteTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.User
  alias Rocketlivery.Users.Delete

  describe "call/1" do
    test "deletes an user in database when id is valid" do
      %{id: id} = insert(:user)

      response = Delete.call(id)

      assert {:ok, %User{id: ^id}} = response
    end
  end

  test "fails to delete an user in database when id is invalid" do
    %{id: id_from_database} = insert(:user)
    id = String.replace(id_from_database, ~r/.$/, &if(&1 == "0", do: "1", else: "0"))

    response = Delete.call(id)

    assert {:error, %Error{status: :not_found, result: _result}} = response
  end
end
