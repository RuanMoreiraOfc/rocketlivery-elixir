defmodule Rocketlivery.Repo.Migrations.CreatePaymentMethodType do
  use Ecto.Migration

  @payment_methods [:money, :credit_card, :debit_card]
  @payment_methods_as_string Enum.map_join(@payment_methods, ", ", &"'#{&1}'")

  def change do
    up_query = "CREATE TYPE payment_method AS ENUM (#{@payment_methods_as_string})"
    down_query = "DROP TYPE payment_method"

    execute(up_query, down_query)
  end
end
