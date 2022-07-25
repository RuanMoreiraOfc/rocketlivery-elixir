<h1 align='center'>

Rocketlivery

</h1>

<div align="center">

[ENGLISH][lang-en]
|
[PORTUGUÊS][lang-pt]
|
[日本語][lang-jp]

</div>

<div align="center">

[![card-build]][btn-goto-build]
[![card-codecov]][btn-goto-codecov]

</div>

<div align="center">

[![card-languages]][btn-null]
[![card-last-commit]][btn-null]
[![card-repo-size]][btn-goto-clone]
[![card-code-size]][btn-null]
[![card-license]][btn-goto-license]
[![card-issues]][btn-goto-issues]

</div>

## About <span id="id-about"/>

**Rocketlivery** is a complex application delivery application, with a report generator for the orders done with cron jobs.

Project made on Ignite with **[Rafael Camarda][btn-tutor]** at Elixir Journey.

## :triangular_ruler: Technology <span id="id-about"/>

It was used on development:

- [Elixir]
- [Decimal]
- [Credo]
- [Exmachina]
- [Pbkdf2][pbkdf2_elixir]
- [Excoveralls]
- [Tesla]
- [Bypass]
- [Mox]
- [Guardian]

## [:eyes: Preview][btn-preview] <span id="id-preview"/>

## :electric_plug: Requirements <span id="id-clone"/>

Before to start, you will need have installed on your computer these programs:

- [Git][btn-git]
- [Elixir][btn-elixir]

Also is good have a code editor like [VSCode][btn-vscode].

## :bulb: Do it by yourself

### Cloning

In your terminal clone the repository and install the dependencies.

###### - to clone the repository

```bash
git clone https://github.com/ruanmoreiraofc/rocketlivery-elixir.git
```

###### - to enter into the folder

```bash
cd rocketlivery-elixir
```

###### - to install the dependencies

```bash
mix deps.get
```

### Setup Database

First of all you should setup [`./config/dev.exs`][btn-example-config-dev] and
[`./config/test.exs`][btn-example-config-test], then run this command in your terminal:

```bash
mix ecto.setup
```

#### Migrations

If need to create a migration, you can do that using this command in your terminal

###### - to create a migration

```bash
mix ecto.gen.migration <migration_name>
```

###### - to consume the migrations

```bash
mix ecto.migrate
```

### Guardian

In order to generate bearer tokens for your api, you need setup [`./config/config.secrets.example`][btn-example-config-secrets], replacing the placeholders with valid data and renaming it to `config.secrets.exs`.

**(ONLY ON `bash`)** you can paste this command to help you out

```bash
GUARDIAN_SECRET=$(mix guardian.gen.secret) \
bash .github/scripts/setup_secret.sh
```

### Usage

Now see the result with:

###### - to test the project

```bash
mix test
```

###### - to run the server

```bash
mix phx.server
```

It will expose the app in [localhost:4000][btn-localhost]

#### Insomnia

You can use the [insomnia file][btn-example-insomnia] to make simple requests to test on development environment!

## :balance_scale: License <span id="id-license"/>

This project is under the MIT license. See the [LICENSE][btn-license] for more information.

# :boy: Author <span id="id-author"/>

<div align="center">

  <p>
    <img
      alt="author-img"
      title="Ruan Moreira de Jesus"
      width="100"
      src="https://github.com/ruanmoreiraofc.png">
  </p>

  <!-- ![author-img] does not work with Github's default profile image -->

Made with :heart: by Ruan Moreira de Jesus!

[![author-card-email]][author-btn-email]
[![author-card-discord]][author-btn-discord]
[![author-card-github]][author-btn-github]

</div>

<!--
  ***---- VARIABLES ----***
-->

[btn-null]: #

<!-- *** AUTHOR *** -->

[author-img]: https://github.com/ruanmoreiraofc.png?size=100 "Ruan Moreira de Jesus"
[author-card-email]: https://img.shields.io/badge/Email--$?style=social&logo=microsoft-outlook
[author-card-discord]: https://img.shields.io/badge/Discord--$?style=social&logo=discord
[author-card-github]: https://img.shields.io/github/followers/ruanmoreiraofc?style=social
[author-btn-email]: mailto:ruanmoreiraofc@hotmail.com "Get in touch!"
[author-btn-discord]: #RuanMoreiraOfc#7904 "RuanMoreiraOfc#7904"
[author-btn-github]: https://github.com/ruanmoreiraofc "Github Profile"

<!-- *** LANGUAGES README *** -->

[lang-en]: #
[lang-pt]: #
[lang-jp]: #

<!-- *** INFO CARDS *** -->

[card-build]: https://github.com/ruanmoreiraofc/rocketlivery-elixir/actions/workflows/workflow.yml/badge.svg
[card-codecov]: https://codecov.io/gh/ruanmoreiraofc/rocketlivery-elixir/branch/main/graph/badge.svg?token=XH26MD5DBE
[card-languages]: https://img.shields.io/github/languages/count/ruanmoreiraofc/rocketlivery-elixir?style=for-the-badge&label=Languages
[card-last-commit]: https://img.shields.io/github/last-commit/ruanmoreiraofc/rocketlivery-elixir?style=for-the-badge&label=Last%20Commit
[card-repo-size]: https://img.shields.io/github/repo-size/ruanmoreiraofc/rocketlivery-elixir?style=for-the-badge&label=Repo%20Size
[card-code-size]: https://img.shields.io/github/languages/code-size/ruanmoreiraofc/rocketlivery-elixir?style=for-the-badge&label=Code%20Size
[card-license]: https://img.shields.io/github/license/ruanmoreiraofc/rocketlivery-elixir?style=for-the-badge&label=License
[card-issues]: https://img.shields.io/github/issues/ruanmoreiraofc/rocketlivery-elixir?style=for-the-badge

<!-- *** MAIN BUTTONS *** -->

[btn-tutor]: https://github.com/rafaelcamarda "Rocketseat Educator"
[btn-git]: https://git-scm.com
[btn-elixir]: https://elixir-lang.org/install.html
[btn-vscode]: https://code.visualstudio.com
[btn-license]: LICENSE
[btn-preview]: https://rocketlivery.gigalixirapp.com/api/

<!-- CARDS -->

[btn-goto-build]: https://github.com/ruanmoreiraofc/rocketlivery-elixir/actions/workflows/workflow.yml
[btn-goto-codecov]: https://codecov.io/gh/RuanMoreiraOfc/rocketlivery-elixir
[btn-goto-clone]: #id-clone
[btn-goto-license]: #id-license
[btn-goto-issues]: https://github.com/ruanmoreiraofc/rocketlivery-elixir/issues?q=is%3Aopen

<!-- DO IT BY YOURSELF -->

[btn-localhost]: http://localhost:4000

<!-- EXAMPLES -->

[btn-example-config-dev]: ./config/dev.exs
[btn-example-config-secrets]: ./config/config.secrets.example
[btn-example-config-test]: ./config/test.exs
[btn-example-insomnia]: insomnia.json

<!-- *** TECHNOLOGY *** -->

[elixir]: https://elixir-lang.org
[credo]: https://github.com/rrrene/credo
[exmachina]: https://github.com/thoughtbot/ex_machina
[decimal]: https://github.com/ericmj/decimal
[pbkdf2_elixir]: https://github.com/riverrun/pbkdf2_elixir
[excoveralls]: https://github.com/parroty/excoveralls
[tesla]: https://github.com/elixir-tesla/tesla
[bypass]: https://github.com/PSPDFKit-labs/bypass
[mox]: https://github.com/dashbitco/mox
[guardian]: https://github.com/ueberauth/guardian
