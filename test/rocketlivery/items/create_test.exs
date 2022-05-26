defmodule Rocketlivery.Items.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.Item
  alias Rocketlivery.Items.Create

  describe "call/1" do
    test "creates an item in database when all params are valid" do
      params = string_params_for(:item_params)

      response = Create.call(params)

      assert {:ok, %Item{id: _id}} = response
    end

    test "fails to create an item in database when any param is invalid" do
      params = string_params_for(:item_params, price: 0)

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: _result}} = response
    end
  end
end
