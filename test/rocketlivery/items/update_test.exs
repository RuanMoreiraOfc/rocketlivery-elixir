defmodule Rocketlivery.Items.UpdateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Ecto.Changeset
  alias Rocketlivery.Item
  alias Rocketlivery.Items.Update

  describe "call/1" do
    test "updates an item in database when all params are valid" do
      %{id: id} = insert(:item)
      price = Decimal.new("3.5")
      new_params = %{"id" => id, "price" => price |> Decimal.to_float()}

      response = Update.call(new_params)

      assert {:ok, %Item{id: ^id, price: ^price}} = response
    end

    test "fails to update an item in database when any param is invalid" do
      %{id: id} = insert(:item)
      new_params = %{"id" => id, "price" => 0}

      response = Update.call(new_params)

      assert {:error, %Changeset{errors: _errors}} = response
    end
  end
end
