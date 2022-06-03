defmodule Rocketlivery.Orders.DeleteTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.Order
  alias Rocketlivery.Orders.Delete

  describe "call/1" do
    test "deletes an order in database when id is valid" do
      %{id: id} = insert(:order)

      response = Delete.call(id)

      assert {:ok, %Order{id: ^id}} = response
    end
  end

  test "fails to delete an order in database when id is invalid" do
    %{id: id_from_database} = insert(:order)
    id = String.replace(id_from_database, ~r/.$/, &if(&1 == "0", do: "1", else: "0"))

    response = Delete.call(id)

    assert {:error, %Error{status: :not_found, result: _result}} = response
  end
end
