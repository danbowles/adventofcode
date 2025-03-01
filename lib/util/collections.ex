defmodule Util.Collections do
  def map_sum(enum, fun) do
    enum
    |> Enum.map(fun)
    |> Enum.sum()
  end
end
