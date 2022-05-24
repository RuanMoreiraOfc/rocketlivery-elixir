defmodule Rocketlivery.Factory do
  use ExMachina.Ecto, repo: Rocketlivery.Repo

  alias Rocketlivery.User

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
end
