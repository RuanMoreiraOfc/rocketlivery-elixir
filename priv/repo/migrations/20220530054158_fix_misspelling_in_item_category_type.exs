defmodule Rocketlivery.Repo.Migrations.FixMisspellingInItemCategoryType do
  use Ecto.Migration

  @old_category :desert
  @new_category :dessert

  def change do
    up_query = "ALTER TYPE item_category RENAME VALUE '#{@old_category}' TO '#{@new_category}'"
    down_query = "ALTER TYPE item_category RENAME VALUE '#{@new_category}' TO '#{@old_category}'"

    execute(up_query, down_query)
  end
end
