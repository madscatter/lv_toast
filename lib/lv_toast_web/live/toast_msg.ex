defmodule LvToastWeb.ToastMsg do
  @ toast_id "toasts"
  defstruct id: @ toast_id, msg: nil, comment: "", key: nil, duration: 0

  @behaviour Access

  @impl Access
  def fetch(term, key), do: Map.fetch(term, key)

  @impl Access
  def get_and_update(data, key, fun), do: Map.get_and_update(data, key, fun)

  @impl Access
  def pop(data, key), do: Map.pop(data, key)

  def get_id(), do: @ toast_id

end

defimpl Enumerable, for: LvToastWeb.ToastMsg do

  def count(enumerable), do: Enumerable.List.count(Map.to_list(enumerable))

  def member?(enumerable, element), do: Enumerable.List.member?(Map.to_list(enumerable), element)

  def reduce(enumerable, acc, fun), do: Enumerable.List.reduce(Map.to_list(enumerable), acc, fun)

  def slice(enumerable), do: Enumerable.List.slice(Map.to_list(enumerable))
end
