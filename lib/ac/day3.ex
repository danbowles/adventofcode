defmodule AC.Day3 do
  @mul_regex ~r/mul\((\d{1,3}),(\d{1,3})\)/
  alias Util.Input

  def load_data() do
    Input.load_day_input(2024, 3)
    |> Enum.join()
  end

  def part_one(data) do
    Regex.scan(@mul_regex, data, capture: :all_but_first)
    |> Enum.map(fn [a, b] -> [String.to_integer(a), String.to_integer(b)] end)
    |> Enum.map(fn [a, b] -> a * b end)
    |> Enum.sum()
  end
end
