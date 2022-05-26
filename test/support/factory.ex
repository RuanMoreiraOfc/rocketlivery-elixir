defmodule Rocketlivery.Factory do
  use ExMachina.Ecto, repo: Rocketlivery.Repo

  alias Rocketlivery.{Item, User}

  def user_params_factory do
    %{
      email: "anyone@email.com",
      password: "12345678",
      address: "St Anywhere",
      name: "Anny One",
      age: 24,
      cpf: "12345678900",
      cep: "05030030"
    }
  end

  def user_factory do
    %User{
      id: "b815baa2-f7a4-4eeb-ad2b-2790d48cbbf3",
      email: "anyone@email.com",
      password: "12345678",
      address: "St Anywhere",
      name: "Anny One",
      age: 24,
      cpf: "12345678900",
      cep: "05030030"
    }
  end

  def item_params_factory do
    %{
      category: :drink,
      name: "Apple Juice",
      description: "Juice made of apples",
      price: Decimal.new("2.5") |> Decimal.to_float(),
      photo: "/priv/static/assets/image.jpg"
    }
  end

  def item_factory do
    %Item{
      id: "7c6576f9-9161-4bba-8b94-d997c6d0f4a1",
      category: :drink,
      name: "Apple Juice",
      description: "Juice made of apples",
      price: Decimal.new("2.5") |> Decimal.to_float(),
      photo: "/priv/static/assets/image.jpg"
    }
  end
end
