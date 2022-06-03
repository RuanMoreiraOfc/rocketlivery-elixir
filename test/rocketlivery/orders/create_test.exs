defmodule Rocketlivery.Orders.CreateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Order
  alias Rocketlivery.Orders.Create

  describe "call/1" do
    test "creates an order in database when all params are valid" do
      params = string_params_for(:order_params)

      response = Create.call(params)

      assert {:ok, %Order{id: _id}} = response
    end
  end
end
