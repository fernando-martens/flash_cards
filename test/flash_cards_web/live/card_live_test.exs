defmodule FlashCardsWeb.CardLiveTest do
  use FlashCardsWeb.ConnCase

  import Phoenix.LiveViewTest
  import FlashCards.DecksFixtures

  @create_attrs %{question: "some question", answer: "some answer"}
  @update_attrs %{question: "some updated question", answer: "some updated answer"}
  @invalid_attrs %{question: nil, answer: nil}

  defp create_card(_) do
    card = card_fixture()
    %{card: card}
  end

  defp create_deck(_) do
    deck = deck_fixture()
    %{deck: deck}
  end

  describe "Index" do
    setup [:create_card, :create_deck]

    test "lists all cards", %{conn: conn, card: card} do
      {:ok, _index_live, html} = live(conn, ~p"/decks/#{card.deck_id}/cards")

      assert html =~ "Listing Cards"
      assert html =~ card.question
    end

    test "saves new card", %{conn: conn, deck: deck} do
      {:ok, index_live, _html} = live(conn, ~p"/decks/#{deck.id}/cards")

      assert index_live |> element("a", "New Card") |> render_click() =~
               "New Card"

      assert_patch(index_live, ~p"/decks/#{deck.id}/cards/new")

      assert index_live
             |> form("#card-form", card: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#card-form", card: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/decks/#{deck.id}/cards")

      html = render(index_live)
      assert html =~ "Card created successfully"
      assert html =~ "some question"
    end

    test "updates card in listing", %{conn: conn, card: card} do
      {:ok, index_live, _html} = live(conn, ~p"/decks/#{card.deck_id}/cards")

      assert index_live |> element("#cards-#{card.id} a", "Edit") |> render_click() =~
               "Edit Card"

      assert_patch(index_live, ~p"/decks/#{card.deck_id}/cards/#{card}/edit")

      assert index_live
             |> form("#card-form", card: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#card-form", card: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/decks/#{card.deck_id}/cards")

      html = render(index_live)
      assert html =~ "Card updated successfully"
      assert html =~ "some updated question"
    end

    test "deletes card in listing", %{conn: conn, card: card} do
      {:ok, index_live, _html} = live(conn, ~p"/decks/#{card.deck_id}/cards")

      assert index_live |> element("#cards-#{card.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cards-#{card.id}")
    end
  end
end
