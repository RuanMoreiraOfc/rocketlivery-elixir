defmodule Rocketlivery.Users.DeleteTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.User
  alias Rocketlivery.Users.Delete

  describe "call/1" do
    test "deletes an user in database when id is valid" do
      %{id: id} = insert(:user)

      response = Delete.call(id)

      assert {:ok, %User{id: ^id}} = response
    end
  end
end
