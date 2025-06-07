defmodule FlashCards.DecksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FlashCards.Decks` context.
  """

  @doc """
  Generate a deck.
  """
  def deck_fixture(attrs \\ %{}) do
    {:ok, deck} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> FlashCards.Decks.create_deck()

    deck
  end

  @doc """
  Generate a card.
  """
  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        question: "some question",
        deck_id: deck_fixture().id
      })
      |> FlashCards.Decks.create_card()

    card
  end
end
