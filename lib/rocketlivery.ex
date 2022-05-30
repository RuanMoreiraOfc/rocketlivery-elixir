defmodule Rocketlivery do
  alias Rocketlivery.Items.Create, as: ItemCreate
  alias Rocketlivery.Items.Delete, as: ItemDelete
  alias Rocketlivery.Items.Get, as: ItemGet
  alias Rocketlivery.Items.Update, as: ItemUpdate

  alias Rocketlivery.Orders.Create, as: OrderCreate
  alias Rocketlivery.Orders.Delete, as: OrderDelete

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
  defdelegate get_item_by_id(id), to: ItemGet, as: :by_id
  defdelegate update_item(params), to: ItemUpdate, as: :call

  defdelegate create_order(params), to: OrderCreate, as: :call
  defdelegate delete_order(id), to: OrderDelete, as: :call
end
