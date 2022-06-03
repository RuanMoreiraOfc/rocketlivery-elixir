defmodule Rocketlivery.Orders.GetTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.Order
  alias Rocketlivery.Orders.Get

  describe "by_id/1" do
    test "gets an order by id from database when id is valid" do
      %{id: id} = insert(:order)

      response = Get.by_id(id)

      assert {:ok, %Order{id: ^id}} = response
    end
  end

  test "fails to get an order by id from database when id is invalid" do
    %{id: id_from_database} = insert(:order)
    id = String.replace(id_from_database, ~r/.$/, &if(&1 == "0", do: "1", else: "0"))

    response = Get.by_id(id)

    assert {:error, %Error{status: :not_found, result: _result}} = response
  end
end
