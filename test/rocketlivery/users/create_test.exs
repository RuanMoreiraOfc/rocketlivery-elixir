defmodule Rocketlivery.Users.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.User
  alias Rocketlivery.Users.Create

  describe "call/1" do
    test "creates an user in database when all params are valid" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id}} = response
    end
  end
end
