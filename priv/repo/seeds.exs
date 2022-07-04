alias Rocketlivery.{Repo.User, Item, Order}

IO.puts("========== INSERTING USER ==========")

user = %User{
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

%User{id: user_id} = Repo.insert!(user)

IO.puts("========== INSERTING ITEMS ==========")

item1 = %Item{
  category: :drink,
  name: "Apple Juice",
  description: "Juice made of apples",
  price: Decimal.new("2.5") |> Decimal.to_float(),
  photo: "/priv/static/assets/image.jpg"
}

%Item{id: item1_id} = Repo.insert!(item1)

#

item2 = %Item{
  category: :dessert,
  name: "Apple Pie",
  description: "Pie made of apples",
  price: Decimal.new("15") |> Decimal.to_float(),
  photo: "/priv/static/assets/image.jpg"
}

%Item{id: item2_id} = Repo.insert!(item2)

IO.puts("========== INSERTING ORDER ==========")

order = %Order{
  user_id: user_id,
  items: [
    item1,
    item1,
    item2
  ],
  address: "St anywhere",
  payment_method: :money,
  notes: "no sugar"
}

Repo.insert!(order)

IO.puts("========== SEEDS DONE ==========")
