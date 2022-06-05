defmodule Rocketlivery.Helpers.MergeChangeset do
  def call(%{changes: current_changes} = changeset, incoming_changes) do
    merged_changes = Map.merge(current_changes, Map.from_struct(incoming_changes))
    Map.merge(changeset, %{changes: merged_changes})
  end
end
