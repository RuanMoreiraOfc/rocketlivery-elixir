defmodule Rocketlivery.Orders.GetTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Order
  alias Rocketlivery.Orders.Get

  describe "by_id/1" do
    test "gets an order by id from database when id is valid" do
      %{id: id} = insert(:order)

      response = Get.by_id(id)

      assert {:ok, %Order{id: ^id}} = response
    end
  end
end
