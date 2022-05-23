defmodule Rocketlivery.Factory do
  use ExMachina

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
end
