<h1 align='center'>

Rocketlivery

</h1>

### Database

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
GUARDIAN_SECRET=$(mix guardian.gen.secret); \
cp config/config.secrets.example config/.t; \
sed -i 's|my_app_name|rocketlivery|g' config/.t; \
sed -i 's|my_module_using_guardian|RocketliveryWeb.Auth.Guardian|' config/.t; \
sed -i "s|secret_key: \".*\"|secret_key: \"$GUARDIAN_SECRET\"|" config/.t; \
mv config/.t config/config.secrets.exs;
echo "END"
```

### Server

After finish all the configurations you can run the server using this command in your terminal

###### - to run the server

```bash
mix phx.server
```

It will expose the app in [localhost:4000][btn-localhost]

#### Insomnia

You can use the [insomnia file][btn-example-insomnia] to make simple requests to test on development environment!

<!-- VARIABLES -->

[btn-localhost]: http://localhost:4000
[btn-example-config-dev]: ./config/dev.exs
[btn-example-config-secrets]: ./config/config.secrets.example
[btn-example-config-test]: ./config/test.exs
[btn-example-insomnia]: insomnia.json
