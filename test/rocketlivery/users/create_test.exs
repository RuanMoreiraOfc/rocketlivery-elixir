defmodule Rocketlivery.Users.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.User
  alias Rocketlivery.Users.Create

  describe "call/1" do
    test "creates an user in database when all params are valid" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id}} = response
    end

    test "fails to create an user in database when any param is invalid" do
      params = build(:user_params, age: 17)

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: _result}} = response
    end
  end
end
