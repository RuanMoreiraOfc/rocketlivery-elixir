defmodule Rocketlivery.Items.GetTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Item
  alias Rocketlivery.Items.Get

  describe "call/1" do
    test "gets an item by id from database when id is valid" do
      %{id: id} = insert(:item)

      response = Get.by_id(id)

      assert {:ok, %Item{id: ^id}} = response
    end
  end
end
