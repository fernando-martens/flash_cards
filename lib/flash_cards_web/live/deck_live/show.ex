defmodule FlashCardsWeb.DeckLive.Show do
  use FlashCardsWeb, :live_view

  alias FlashCards.Decks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:deck, Decks.get_deck!(id))
     |> assign(:points, [1, 2, 3, 4, 5])}
  end

  defp page_title(:show), do: "Show Deck"
  defp page_title(:edit), do: "Edit Deck"
end
