defmodule Rocketlivery do
  alias Rocketlivery.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
end
