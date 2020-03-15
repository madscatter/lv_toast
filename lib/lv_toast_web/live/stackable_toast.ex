defmodule LvToastWeb.StackableToast do
  use Phoenix.LiveComponent
  alias LvToastWeb.ToastMsg

  @toast_transition_time 300
  @toast_show_time 50

  defmodule Toast do
    defstruct comment: "", hide: true, timer: nil, duration: 3000
  end

  def render(assigns) do
    Phoenix.View.render(LvToastWeb.ToastLiveView, "toasts.html", assigns)
  end

  def mount(socket) do
    {:ok, assign(socket, toasts: Keyword.new())}
  end

  def create_key() do
    System.monotonic_time() |> Integer.to_string() |> String.to_atom()
  end

  def add_toast(assigns = %ToastMsg{comment: comment, duration: duration}, socket) do
    key = create_key()
    ref = %ToastMsg{assigns | msg: :show_toast, key: key} |> set_timer(@toast_show_time)
    (socket |> get_toast) ++ [{key, %Toast{comment: comment, timer: ref, duration: duration }}]
  end

  def show_toast(assigns = %ToastMsg{key: key}, socket) do
    {_, new_list} = Keyword.get_and_update(socket |> get_toast(), key, fn item ->
      ref = %ToastMsg{assigns | msg: :hide_toast} |> set_timer(item.duration)
      {item, %Toast{item | hide: false, timer: ref}}
    end)
    new_list
  end

  def hide_toast(assigns = %ToastMsg{key: key}, socket) do
    {_, new_list} = Keyword.get_and_update(socket |> get_toast(), key, fn item ->
      ref = %ToastMsg{assigns | msg: :remove_toast} |> set_timer(@toast_transition_time)
      {item, %Toast{item | hide: true, timer: ref}}
    end)
    new_list
  end

  def remove_toast(%ToastMsg{key: key}, socket) do
    Keyword.delete(socket |> get_toast(), key)
  end

  def get_toast(socket) do
    socket.assigns.toasts
  end

  def get_func_for(msg) do
    %{
      :add_toast    => &add_toast/2,
      :show_toast   => &show_toast/2,
      :hide_toast   => &hide_toast/2,
      :remove_toast => &remove_toast/2,
    }[msg]
  end

  def set_timer(%ToastMsg{} = tm, time_after) do
    Process.send_after(self(), tm, time_after)
  end

  def update(assigns = %ToastMsg{msg: msg}, socket) do
    {:ok, assign(socket, toasts: get_func_for(msg).(assigns, socket))}
  end

  def update(_, socket) do
    {:ok, socket}
  end

  def handle_event("toast_click-" <> key, _params, socket ) do
    current_key = key |> String.to_atom()
    %Toast{timer: ref} = Keyword.get(socket |> get_toast(), current_key)
    Process.cancel_timer(ref)

    {:noreply, assign(socket, toasts: hide_toast(%ToastMsg{key: current_key}, socket))}
  end


end