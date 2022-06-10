defmodule RocketliveryWeb.UsersViewTest do
  use RocketliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rocketlivery.Factory

  alias Rocketlivery.User
  alias RocketliveryWeb.Auth.Guardian
  alias RocketliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    {:ok, token, _claims} = Guardian.encode_and_sign(user)

    response = render(UsersView, "create.json", user: user, token: token)

    assert %{
             message: "User created!",
             token: ^token,
             user: %User{
               id: "b815baa2-f7a4-4eeb-ad2b-2790d48cbbf3",
               email: "anyone@email.com",
               name: "Anny One",
               age: 24,
               cpf: "12345678900",
               address: "St Anywhere",
               cep: "05030030",
               city: "São Paulo",
               uf: "SP"
             }
           } = response
  end

  test "renders sign_in.json" do
    token = "123456789"

    response = render(UsersView, "sign_in.json", token: token)

    assert %{token: "123456789"} = response
  end

  test "renders user.json" do
    user = build(:user, age: 19)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %User{
               id: "b815baa2-f7a4-4eeb-ad2b-2790d48cbbf3",
               email: "anyone@email.com",
               name: "Anny One",
               age: 19,
               cpf: "12345678900",
               address: "St Anywhere",
               cep: "05030030",
               city: "São Paulo",
               uf: "SP"
             }
           } = response
  end
end
