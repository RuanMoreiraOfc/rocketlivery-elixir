defmodule Rocketlivery.Orders.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.Order
  alias Rocketlivery.Orders.Create

  describe "call/1" do
    test "creates an order in database when all params are valid" do
      params = string_params_for(:order_params)

      response = Create.call(params)

      assert {:ok, %Order{id: _id}} = response
    end

    test "fails to create an order in database when any param is invalid" do
      params = string_params_for(:order_params, user_id: nil)

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: _result}} = response
    end
  end
end
