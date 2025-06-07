defmodule FlashCardsWeb.CardLive.Index do
  use FlashCardsWeb, :live_view

  alias FlashCards.Decks
  alias FlashCards.Decks.Card

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :cards, Decks.list_cards())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    card = Decks.get_card!(id)

    socket
    |> assign(:page_title, "Edit Card")
    |> assign(:deck_id, card.deck_id)
    |> assign(:card, card)
  end

  defp apply_action(socket, :new, %{"deck_id" => deck_id}) do
    socket
    |> assign(:page_title, "New Card")
    |> assign(:deck_id, deck_id)
    |> assign(:card, %Card{})
  end

  defp apply_action(socket, :index, %{"deck_id" => deck_id}) do
    socket
    |> assign(:page_title, "Listing Cards")
    |> assign(:deck_id, deck_id)
    |> assign(:card, nil)
  end

  @impl true
  def handle_info({FlashCardsWeb.CardLive.FormComponent, {:saved, card}}, socket) do
    {:noreply, stream_insert(socket, :cards, card)}
  end

  @impl true
  @spec handle_event(<<_::48>>, map(), Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("delete", %{"id" => id}, socket) do
    card = Decks.get_card!(id)
    {:ok, _} = Decks.delete_card(card)

    {:noreply, stream_delete(socket, :cards, card)}
  end
end
