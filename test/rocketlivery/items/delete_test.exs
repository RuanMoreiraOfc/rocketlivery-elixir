defmodule Rocketlivery.Items.DeleteTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Rocketlivery.Helpers.Error
  alias Rocketlivery.Item
  alias Rocketlivery.Items.Delete

  describe "call/1" do
    test "deletes an item in database when id is valid" do
      %{id: id} = insert(:item)

      response = Delete.call(id)

      assert {:ok, %Item{id: ^id}} = response
    end
  end

  test "fails to delete an item in database when id is invalid" do
    %{id: id_from_database} = insert(:item)
    id = String.replace(id_from_database, ~r/.$/, &if(&1 == "0", do: "1", else: "0"))

    response = Delete.call(id)

    assert {:error, %Error{status: :not_found, result: _result}} = response
  end
end
