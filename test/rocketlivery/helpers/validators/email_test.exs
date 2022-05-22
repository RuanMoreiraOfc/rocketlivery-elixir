defmodule Rocketlivery.Helpers.Validators.EmailTest do
  use ExUnit.Case

  alias Rocketlivery.Helpers.Validators.Email, as: EmailValidatorHelper

  describe "regex/0" do
    setup do
      regex = EmailValidatorHelper.regex()
      matches = &Regex.match?(regex, &1)
      dont_matches = &(Regex.match?(regex, &1) == false)

      {:ok, regex: regex, matches: matches, dont_matches: dont_matches}
    end

    test "succeed when compared against a correct list", %{dont_matches: dont_matches} do
      expected_response = []

      response_list = [
        # local
        "email@email.email",
        "emai.l@email.email",
        "ema.i.l@email.email",
        "emai-l@email.email",
        "ema-i-l@email.email",
        "emai--l@email.email",
        "ema--i--l@email.email",
        # domain
        "email@e.mail.email",
        "email@e.m.ail.email",
        "email@e-mail.email",
        "email@e--mail.email",
        "email@e-m-ail.email",
        "email@e--m--ail.email",
        # tld
        "email@email.e-mail",
        "email@email.e--mail",
        "email@email.e-m-ail",
        "email@email.e--m--ail"
      ]

      assert Enum.filter(response_list, dont_matches) == expected_response
    end

    test "fail when compared against a failing list", %{matches: matches} do
      expected_response = []

      response_list = [
        # local
        "@email.email",
        "-email@email.email",
        "email-@email.email",
        ".email@email.email",
        "email.@email.email",
        "emai..l@email.email",
        "emai.-l@email.email",
        "emai-.l@email.email",
        # domain
        "email@.email",
        "email@-email.email",
        "email@email-.email",
        "email@.email.email",
        "email@email..email",
        "email@emai..l.email",
        "email@emai.-l.email",
        "email@emai-.l.email",
        # tld
        "email@email",
        "email@email.-email",
        "email@email.email-"
      ]

      assert Enum.filter(response_list, matches) == expected_response
    end
  end
end
