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

    test "fails to create a changeset when all params are invalid" do
      params =
        string_params_for(:item_params,
          category: :invalid_category,
          name: nil,
          description: nil,
          price: 0,
          photo: nil
        )

      expected_response = %{
        category: ["is invalid"],
        name: ["can't be blank"],
        description: ["can't be blank"],
        price: ["must be greater than 0"],
        photo: ["can't be blank"]
      }

      response = Item.changeset(params)

      assert errors_on(response) == expected_response
    end

    test "updates a changeset when all params are valid" do
      params = string_params_for(:item_params)

      new_params = %{
        "description" => "A new description!"
      }

      changeset = Item.changeset(params)

      response = Item.changeset(changeset, new_params)

      assert %Changeset{valid?: true, changes: %{description: "A new description!"}} = response
    end
  end
end
