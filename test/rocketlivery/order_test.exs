defmodule Rocketlivery.OrderTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Ecto.Changeset
  alias Rocketlivery.Order

  describe "changeset/2" do
    test "creates a changeset when all params are valid" do
      item = build(:item)
      params = string_params_for(:order_params)

      response = Order.changeset(params, [item])

      assert %Changeset{valid?: true, changes: %{payment_method: :money}} = response
    end

    test "fails to create a changeset when all params are invalid" do
      params =
        string_params_for(:order_params,
          user_id: nil,
          address: nil,
          notes: nil,
          payment_method: :invalid_category
        )

      expected_response = %{
        user_id: ["can't be blank"],
        address: ["can't be blank"],
        items: ["is invalid"],
        notes: ["can't be blank"],
        payment_method: ["is invalid"]
      }

      response = Order.changeset(params, [nil])

      assert errors_on(response) == expected_response
    end

    test "updates a changeset when all params are valid" do
      item = build(:item)
      params = string_params_for(:order_params)

      new_params = %{
        "address" => "New address!"
      }

      changeset = Order.changeset(params, [item])

      response = Order.changeset(changeset, new_params, [item])

      assert %Changeset{valid?: true, changes: %{address: "New address!"}} = response
    end
  end
end
