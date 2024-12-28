defmodule AC.Day1 do
  def load_data() do
    Util.Input.load_day_input(2024, 1, "\n")
    |> Enum.map(&String.split(&1, ~r/\s+/, trim: true))
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def part_one([l, r]) do
    l
    |> Enum.sort()
    |> Enum.zip(r |> Enum.sort())
    |> Enum.reduce(0, fn {a, b}, acc -> acc + abs(a - b) end)
  end

  def part_two([l, r]) do
    f = Enum.frequencies(r)
    l |> Enum.map(fn la -> la * Map.get(f, la, 0) end) |> Enum.sum()
  end
end
