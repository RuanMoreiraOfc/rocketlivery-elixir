defmodule Rocketlivery.Orders.UpdateTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Ecto.Changeset
  alias Rocketlivery.Helpers.Error
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

    test "fails to update an order in database when any param is invalid" do
      %{id: id} = insert(:order)
      new_params = %{"id" => id, "notes" => nil}

      response = Update.call(new_params)

      assert {:error,
              %Error{
                status: :bad_request,
                result: %Changeset{errors: _errors}
              }} = response
    end

    test "fails to update an order in database when id is invalid" do
      %{id: id_from_database} = insert(:order)
      id = String.replace(id_from_database, ~r/.$/, &if(&1 == "0", do: "1", else: "0"))
      new_params = %{"id" => id}

      response = Update.call(new_params)

      assert {:error, %Error{status: :not_found, result: _result}} = response
    end
  end
end
