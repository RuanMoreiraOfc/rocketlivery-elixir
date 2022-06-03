defmodule Rocketlivery.ViaCep.Response do
  @keys [:city, :uf]

  @enforce_keys @keys

  defstruct @keys

  def build(city, uf) do
    %__MODULE__{
      city: city,
      uf: uf
    }
  end
end
