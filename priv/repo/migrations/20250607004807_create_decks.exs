defmodule FlashCards.Repo.Migrations.CreateDecks do
  use Ecto.Migration

  def change do
    create table(:decks, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
