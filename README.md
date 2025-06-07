# FlashCards

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Start your Phoenix app with:

    mix phx.server

Commands:

    docker-compose up -d

    mix ecto.create
    mix ecto.migrate
    mix ecto.drop

    rm -rf _build/

    mix phx.gen.live Decks Deck decks name:string

    mix phx.gen.live Decks Card cards question:string answer:string deck_id:references:decks --binary-id

