defmodule Rocketlivery.Users.GetTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.User
  alias Rocketlivery.Users.Get

  describe "call/1" do
    test "gets an user by id from database when id is valid" do
      %{id: id} = insert(:user)

      response = Get.by_id(id)

      assert {:ok, %User{id: ^id}} = response
    end
  end

  test "fails to get an user by id from database when id is invalid" do
    %{id: id_from_database} = insert(:user)
    id = String.replace(id_from_database, ~r/.$/, &if(&1 == "0", do: "1", else: "0"))

    response = Get.by_id(id)

    assert {:error, %Error{status: :not_found, result: _result}} = response
  end
end
