defmodule Rocketlivery.Items.DeleteTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Item
  alias Rocketlivery.Items.Delete

  describe "call/1" do
    test "deletes an item in database when id is valid" do
      %{id: id} = insert(:item)

      response = Delete.call(id)

      assert {:ok, %Item{id: ^id}} = response
    end
  end
end
