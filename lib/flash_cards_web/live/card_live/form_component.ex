defmodule FlashCardsWeb.CardLive.FormComponent do
  use FlashCardsWeb, :live_component

  alias FlashCards.Decks

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage card records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="card-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:question]} type="text" label="Question" />
        <.input field={@form[:answer]} type="text" label="Answer" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Card</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{card: card} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Decks.change_card(card))
     end)}
  end

  @impl true
  def handle_event("validate", %{"card" => card_params}, socket) do
    changeset = Decks.change_card(socket.assigns.card, card_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"card" => card_params}, socket) do
    card_params = Map.put(card_params, "deck_id", socket.assigns.deck_id)
    save_card(socket, socket.assigns.action, card_params)
  end

  defp save_card(socket, :edit, card_params) do
    case Decks.update_card(socket.assigns.card, card_params) do
      {:ok, card} ->
        notify_parent({:saved, card})

        {:noreply,
         socket
         |> put_flash(:info, "Card updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_card(socket, :new, card_params) do
    case Decks.create_card(card_params) do
      {:ok, card} ->
        notify_parent({:saved, card})

        {:noreply,
         socket
         |> put_flash(:info, "Card created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
