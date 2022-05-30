defmodule Rocketlivery.Items.GetTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.Item
  alias Rocketlivery.Items.Get

  describe "by_id/1" do
    test "gets an item by id from database when id is valid" do
      %{id: id} = insert(:item)

      response = Get.by_id(id)

      assert {:ok, %Item{id: ^id}} = response
    end
  end

  test "fails to get an item by id from database when id is invalid" do
    %{id: id_from_database} = insert(:item)
    id = String.replace(id_from_database, ~r/.$/, &if(&1 == "0", do: "1", else: "0"))

    response = Get.by_id(id)

    assert {:error, %Error{status: :not_found, result: _result}} = response
  end
end
