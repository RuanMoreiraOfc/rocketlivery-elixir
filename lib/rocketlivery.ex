defmodule Rocketlivery do
  alias Rocketlivery.Items.Create, as: ItemCreate
  alias Rocketlivery.Items.Delete, as: ItemDelete

  alias Rocketlivery.Users.Create, as: UserCreate
  alias Rocketlivery.Users.Delete, as: UserDelete
  alias Rocketlivery.Users.Get, as: UserGet
  alias Rocketlivery.Users.Update, as: UserUpdate

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate update_user(params), to: UserUpdate, as: :call

  defdelegate create_item(params), to: ItemCreate, as: :call
  defdelegate delete_item(id), to: ItemDelete, as: :call
end
