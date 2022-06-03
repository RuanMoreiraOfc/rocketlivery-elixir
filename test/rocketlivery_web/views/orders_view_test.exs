defmodule RocketliveryWeb.OrdersViewTest do
  use RocketliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rocketlivery.Factory

  alias Rocketlivery.{Item, Order}
  alias RocketliveryWeb.OrdersView

  test "renders create.json" do
    price = Decimal.new("2.5") |> Decimal.to_float()
    order = build(:order)

    response = render(OrdersView, "create.json", order: order)

    assert %{
             message: "Order created!",
             order: %Order{
               id: "4b9eb78b-a91f-4e6c-bda4-01b462f946ff",
               user_id: "b815baa2-f7a4-4eeb-ad2b-2790d48cbbf3",
               items: [
                 %Item{
                   id: "7c6576f9-9161-4bba-8b94-d997c6d0f4a1",
                   category: :drink,
                   name: "Apple Juice",
                   description: "Juice made of apples",
                   price: ^price,
                   photo: "/priv/static/assets/image.jpg"
                 }
               ],
               address: "St anywhere",
               payment_method: :money,
               notes: "no sugar"
             }
           } = response
  end
end
