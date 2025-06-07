defmodule FlashCardsWeb.CardLive.Show do
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
     |> assign(:card, Decks.get_card!(id))}
  end

  defp page_title(:show), do: "Show Card"
  defp page_title(:edit), do: "Edit Card"
end
