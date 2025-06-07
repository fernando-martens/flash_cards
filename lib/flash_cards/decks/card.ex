defmodule FlashCards.Decks.Card do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cards" do
    field :question, :string
    field :answer, :string
    field :deck_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:question, :answer, :deck_id])
    |> validate_required([:question, :answer, :deck_id])
  end
end
