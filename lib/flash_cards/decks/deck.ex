defmodule FlashCards.Decks.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "decks" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deck, attrs) do
    deck
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
