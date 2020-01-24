defmodule YuuWeb.KanaInput do
  use Phoenix.LiveView
  import Phoenix.HTML.Form, only: [checkbox: 3]

  # def render(assigns) do
  #   ~L"""
  #   <div>
  #     <form phx-change="to_kana" phx-submit="search">
  #       <input type="text" name="to_kana" value="<%= @query %>" placeholder="Romaji to かな.">
  #     </form>
  #   </div>

  #   """
  # end
  def render(assigns) do
    ~L"""
    <form phx-change="suggest" class="input-group mb-3">
      <input
        type="text"
        name="q"
        value="<%= @query %>"
        data-romaji="<%= @romaji %>"
        data-kana="<%= @kana %>"
        phx-hook="ToKana"
        class="form-control"
        placeholder="Search"
        aria-label="search"
        aria-describedby="basic-addon2">

      <div class="input-group-append">
      <button class="btn btn-outline-secondary" phx-click="toggle_kana" class="btn btn-outline-secondary" type="button"><%= if @kana? do %>かな<% else %>EN<% end %> </button>
    </form>
    """
  end

  def mount(_session, socket) do
    {:ok,
     assign(socket,
       query: nil,
       kana?: true,
       kana: "",
       romaji: ""
     )}
  end

  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) <= 100 do
    current_query = socket.assigns[:query] || ""

    # THIS IS GARBAGE
    # new =
    #   if current_query == "" do
    #     query
    #   else
    #     String.replace_leading(query, current_query, "")
    #   end

    # romaji =
    #   if String.length(current_query) > String.length(query) do
    #     socket.assigns[:romaji] <> new
    #   else
    #   end

    romaji = kana = Wanakana.to_kana(query, %{imemode: true})
    {:noreply, assign(socket, query: query, romaji: romaji, kana: kana)}
  end

  def handle_event("toggle_kana", _, socket) do
    {:noreply, assign(socket, kana?: !socket.assigns[:kana?])}
  end
end
