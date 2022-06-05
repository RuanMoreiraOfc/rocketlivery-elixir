defmodule Rocketlivery.ViaCep.Behaviour do
  alias Rocketlivery.Helpers.Error, as: ErrorHelper
  alias Rocketlivery.ViaCep.Response

  @typep successful_call :: {:ok, Response.t()}
  @typep failing_call :: {:error, ErrorHelper.t()}

  @callback get_cep_info(String.t()) :: successful_call | failing_call
end
