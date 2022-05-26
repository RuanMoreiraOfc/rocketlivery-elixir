defmodule Rocketlivery.Items.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Item
  alias Rocketlivery.Items.Create

  describe "call/1" do
    test "creates an item in database when all params are valid" do
      params = string_params_for(:item_params)

      response = Create.call(params)

      assert {:ok, %Item{id: _id}} = response
    end
  end
end
