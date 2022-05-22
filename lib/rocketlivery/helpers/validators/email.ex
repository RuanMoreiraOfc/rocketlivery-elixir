defmodule Rocketlivery.Helpers.Validators.Email do
  def regex do
    %{source: valid_word_chars} = ~r/[a-zA-Z\d]/
    %{source: valid_word_chars_stack} = ~r/#{valid_word_chars}*/

    %{source: starts_empty} = ~r/(?<!.)/
    %{source: ends_empty} = ~r/(?!.)/
    %{source: precede_with_word_chars} = ~r/(?<=#{valid_word_chars})/
    %{source: succeed_with_word_chars} = ~r/(?=#{valid_word_chars})/

    %{source: includes_only_word_chars} = ~r/#{starts_empty}#{valid_word_chars}+#{ends_empty}/

    # EMAIL LOCAL PART can alse includes
    #    Regex.escape("!#$%&'*+-/=?^_`{|}~/")
    # and this when wrapped by quotes
    #   Regex.escape("\"(),:;<>@[\]")
    %{source: includes_only_local_part_chars} =
      ~r/#{includes_only_word_chars}|#{starts_empty}(#{valid_word_chars_stack}#{precede_with_word_chars}(\.?|-*){0,1}#{succeed_with_word_chars}#{valid_word_chars_stack})+#{ends_empty}/

    %{source: includes_only_domain_chars} =
      ~r/#{includes_only_word_chars}|#{starts_empty}(#{valid_word_chars_stack}#{precede_with_word_chars}(\.?|-*){0,1}#{succeed_with_word_chars}#{valid_word_chars_stack})+#{ends_empty}/

    %{source: includes_only_tld_chars} =
      ~r/#{includes_only_word_chars}|#{starts_empty}(#{valid_word_chars_stack}#{precede_with_word_chars}-*#{succeed_with_word_chars}#{valid_word_chars_stack})+#{ends_empty}/

    # ***

    includes_valid_local_part =
      includes_only_local_part_chars
      |> String.replace(starts_empty, "")
      |> String.replace(ends_empty, "")

    includes_valid_domain =
      includes_only_domain_chars
      |> String.replace(starts_empty, "")
      |> String.replace(ends_empty, "")

    includes_valid_tld =
      includes_only_tld_chars
      |> String.replace(starts_empty, "")
      |> String.replace(ends_empty, "")

    email_regex =
      ~r/#{starts_empty}(#{includes_valid_local_part})@(#{includes_valid_domain})\.(#{includes_valid_tld})#{ends_empty}/

    email_regex
  end
end
