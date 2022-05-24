defmodule RocketliveryWeb.UsersViewTest do
  use RocketliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rocketlivery.Factory

  alias Rocketlivery.User
  alias RocketliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %User{
               id: "b815baa2-f7a4-4eeb-ad2b-2790d48cbbf3",
               email: "anyone@email.com",
               name: "Anny One",
               age: 24,
               cpf: "12345678900",
               address: "St Anywhere",
               cep: "05030030"
             }
           } = response
  end
end
