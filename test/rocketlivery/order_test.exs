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
  end
end
