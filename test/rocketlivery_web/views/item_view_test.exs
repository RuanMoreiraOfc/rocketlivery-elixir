defmodule RocketliveryWeb.ItemsViewTest do
  use RocketliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rocketlivery.Factory

  alias Rocketlivery.Item
  alias RocketliveryWeb.ItemsView

  test "renders create.json" do
    price = Decimal.new("2.5") |> Decimal.to_float()
    item = build(:item)

    response = render(ItemsView, "create.json", item: item)

    assert %{
             message: "Item created!",
             item: %Item{
               id: "7c6576f9-9161-4bba-8b94-d997c6d0f4a1",
               category: :drink,
               name: "Apple Juice",
               description: "Juice made of apples",
               price: ^price,
               photo: "/priv/static/assets/image.jpg"
             }
           } = response
  end
end
