defmodule FlashCards.DecksTest do
  use FlashCards.DataCase

  alias FlashCards.Decks

  describe "decks" do
    alias FlashCards.Decks.Deck

    import FlashCards.DecksFixtures

    @invalid_attrs %{name: nil}

    test "list_decks/0 returns all decks" do
      deck = deck_fixture()
      assert Decks.list_decks() == [deck]
    end

    test "get_deck!/1 returns the deck with given id" do
      deck = deck_fixture()
      assert Decks.get_deck!(deck.id) == deck
    end

    test "create_deck/1 with valid data creates a deck" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Deck{} = deck} = Decks.create_deck(valid_attrs)
      assert deck.name == "some name"
    end

    test "create_deck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_deck(@invalid_attrs)
    end

    test "update_deck/2 with valid data updates the deck" do
      deck = deck_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Deck{} = deck} = Decks.update_deck(deck, update_attrs)
      assert deck.name == "some updated name"
    end

    test "update_deck/2 with invalid data returns error changeset" do
      deck = deck_fixture()
      assert {:error, %Ecto.Changeset{}} = Decks.update_deck(deck, @invalid_attrs)
      assert deck == Decks.get_deck!(deck.id)
    end

    test "delete_deck/1 deletes the deck" do
      deck = deck_fixture()
      assert {:ok, %Deck{}} = Decks.delete_deck(deck)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_deck!(deck.id) end
    end

    test "change_deck/1 returns a deck changeset" do
      deck = deck_fixture()
      assert %Ecto.Changeset{} = Decks.change_deck(deck)
    end
  end

  describe "cards" do
    alias FlashCards.Decks.Card

    import FlashCards.DecksFixtures

    @invalid_attrs %{question: nil, answer: nil}

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Decks.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Decks.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      deck = deck_fixture()

      valid_attrs = %{question: "some question", answer: "some answer", deck_id: deck.id}

      assert {:ok, %Card{} = card} = Decks.create_card(valid_attrs)
      assert card.question == "some question"
      assert card.answer == "some answer"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      update_attrs = %{question: "some updated question", answer: "some updated answer"}

      assert {:ok, %Card{} = card} = Decks.update_card(card, update_attrs)
      assert card.question == "some updated question"
      assert card.answer == "some updated answer"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Decks.update_card(card, @invalid_attrs)
      assert card == Decks.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Decks.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Decks.change_card(card)
    end
  end
end
