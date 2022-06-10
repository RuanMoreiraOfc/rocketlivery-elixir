defmodule Rocketlivery.Factory do
  use ExMachina.Ecto, repo: Rocketlivery.Repo

  alias Rocketlivery.{Item, Order, User}
  alias Rocketlivery.ViaCep.Response

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

  def user_cep_info_factory do
    cep_info = %Response{
      city: "São Paulo",
      uf: "SP"
    }

    Map.from_struct(cep_info)
  end

  def user_factory do
    %User{
      id: "b815baa2-f7a4-4eeb-ad2b-2790d48cbbf3",
      email: "anyone@email.com",
      password: "12345678",
      password_hash: Pbkdf2.add_hash("12345678").password_hash,
      address: "St Anywhere",
      name: "Anny One",
      age: 24,
      cpf: "12345678900",
      cep: "05030030",
      city: "São Paulo",
      uf: "SP"
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

  def order_params_factory do
    %{
      user_id: insert(:user).id,
      items: [
        %{
          id: insert(:item).id,
          quantity: 1
        }
      ],
      address: "St anywhere",
      payment_method: :money,
      notes: "no sugar"
    }
  end

  def order_factory do
    %Order{
      id: "4b9eb78b-a91f-4e6c-bda4-01b462f946ff",
      user_id: insert(:user).id,
      items: [
        build(:item)
      ],
      address: "St anywhere",
      payment_method: :money,
      notes: "no sugar"
    }
  end
end
