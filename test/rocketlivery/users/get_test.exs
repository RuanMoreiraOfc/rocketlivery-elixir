defmodule Rocketlivery.Users.GetTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.User
  alias Rocketlivery.Users.Get

  describe "call/1" do
    test "gets an user by id from database when id is valid" do
      %{id: id} = insert(:user)

      response = Get.by_id(id)

      assert {:ok, %User{id: ^id}} = response
    end
  end
end
