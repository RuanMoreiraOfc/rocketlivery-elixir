defmodule Rocketlivery.ItemTest do
  use Rocketlivery.DataCase, async: true

  import Rocketlivery.Factory

  alias Ecto.Changeset
  alias Rocketlivery.Item

  describe "changeset/2" do
    test "creates a changeset when all params are valid" do
      params = string_params_for(:item_params)

      response = Item.changeset(params)

      assert %Changeset{valid?: true, changes: %{category: :drink}} = response
    end
  end
end
