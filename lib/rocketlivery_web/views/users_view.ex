defmodule RocketliveryWeb.UsersView do
  use RocketliveryWeb, :view

  alias Rocketlivery.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{
      message: "User created!",
      user: user,
      token: token
    }
  end

  def render("user.json", %{user: %User{} = user}), do: %{user: user}
end
