defmodule LvToastWeb.ToastLive do
  use Phoenix.LiveView
  alias LvToastWeb.StackableToast
  alias LvToastWeb.ToastMsg

  @toast_id ToastMsg.get_id()

  def render(assigns) do
    Phoenix.View.render(LvToastWeb.ToastLiveView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("add_toast", %{"make_toast" => %{"comment" => comment, "duration"=> duration}}, socket) do
    {val, _} = duration |> Integer.parse()
    send_update StackableToast, %ToastMsg{msg: :add_toast, comment: comment, duration: val*1000}
    {:noreply, socket}
  end

  def handle_info(assigns = %ToastMsg{}, socket) do
    send_update StackableToast, assigns
    {:noreply, socket}
  end

end