defmodule Rocketlivery.Users.UpdateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.User
  alias Rocketlivery.Users.Update

  describe "call/1" do
    test "updates an user in database when all params are valid" do
      %{id: id} = insert(:user)
      new_params = %{"id" => id, "age" => 200}

      response = Update.call(new_params)

      assert {:ok, %User{id: ^id, age: 200}} = response
    end
  end
end
