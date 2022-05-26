<h1 align='center'>

Rocketlivery

</h1>

### Database

First of all you should setup [`./config/dev.exs`](./config/dev.exs) and
[`./config/test.exs`](./config/test.exs), then run this command in your terminal:

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
