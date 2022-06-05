defmodule Rocketlivery.Helpers.MockUserParams do
  @fields [
    :city,
    :uf
  ]

  @mock_value "__placeholder__"

  def call(params) do
    new_keys = Enum.into(@fields, %{}, &{&1, @mock_value})

    params
    |> Map.merge(new_keys)
    |> Enum.into(%{}, &remap_key/1)
  end

  defp remap_key({key, value}) when is_atom(key) do
    key_as_string = Atom.to_string(key)

    {key_as_string, value}
  end

  defp remap_key(item), do: item
end
