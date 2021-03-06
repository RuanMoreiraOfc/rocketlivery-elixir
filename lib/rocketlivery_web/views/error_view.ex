defmodule RocketliveryWeb.ErrorView do
  use RocketliveryWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{result: %Changeset{} = changeset}) do
    %{
      message: translate_errors(changeset)
    }
  end

  def render("error.json", %{result: result}) do
    %{
      message: result
    }
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, &parse_error_to_message/1)
  end

  defp parse_error_to_message(
         {_msg,
          [
            type: {
              :parameterized,
              Ecto.Enum,
              %{mappings: options_tuple_list}
            },
            validation: :cast
          ]} = error
       ) do
    core_msg = get_core_msg(error)
    valid_options = Enum.map_join(options_tuple_list, ", ", &"'#{elem(&1, 1)}'")

    "#{core_msg}, valid options are: [#{valid_options}]"
  end

  defp parse_error_to_message(error), do: get_core_msg(error)

  defp get_core_msg({msg, opts}) do
    Regex.replace(~r/%{(\w+)}/, msg, fn _, key ->
      opts
      |> Keyword.get(String.to_existing_atom(key), key)
      |> to_string()
    end)
  end
end
