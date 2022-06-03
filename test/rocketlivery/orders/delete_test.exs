defmodule Rocketlivery.Orders.DeleteTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Order
  alias Rocketlivery.Orders.Delete

  describe "call/1" do
    test "deletes an order in database when id is valid" do
      %{id: id} = insert(:order)

      response = Delete.call(id)

      assert {:ok, %Order{id: ^id}} = response
    end
  end
end
