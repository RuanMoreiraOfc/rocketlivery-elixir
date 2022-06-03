defmodule Rocketlivery.Orders.UpdateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Order
  alias Rocketlivery.Orders.Update

  describe "call/1" do
    test "updates an order in database when all params are valid" do
      %{id: id} = insert(:order)
      notes = "new notes"
      new_params = %{"id" => id, "notes" => notes}

      response = Update.call(new_params)

      assert {:ok, %Order{id: ^id, notes: ^notes}} = response
    end
  end
end
