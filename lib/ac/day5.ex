defmodule AC.Day5 do
  use AC.Runner

  def load_data() do
    Input.load_day_input(2024, 5, "\n\n")
    |> then(fn [rules, updates] ->
      {
        rules
        |> String.split("\n")
        |> Enum.map(&(&1 |> String.split("|", trim: true) |> List.to_tuple()))
        |> MapSet.new(),
        updates
        |> String.split("\n")
        |> Enum.filter(fn update -> update != "" end)
        |> Enum.map(&String.split(&1, ","))
      }
    end)
  end

  def part_one({rules, updates}) do
    updates
    |> Enum.filter(fn update -> correct_order?(rules, update) end)
    |> Enum.map(fn update -> update |> Enum.at(div(length(update), 2)) |> String.to_integer() end)
    |> Enum.sum()
  end

  def part_two({rules, updates}) do
    updates
    |> Enum.reject(fn update -> correct_order?(rules, update) end)
    |> Enum.map(fn update ->
      update
      |> Enum.sort(fn a, b -> not MapSet.member?(rules, {b, a}) end)
    end)
    |> Enum.map(fn update -> update |> Enum.at(div(length(update), 2)) |> String.to_integer() end)
    |> Enum.sum()
  end

  defp correct_order?(rules, update) do
    update
    |> Enum.with_index(1)
    |> Enum.map(fn {val, idx} ->
      update
      |> Enum.slice(idx..-1//1)
      |> Enum.map(fn slice -> {val, slice} end)
    end)
    |> Enum.all?(fn order_item ->
      Enum.all?(order_item, fn {a, b} -> !MapSet.member?(rules, {b, a}) end)
    end)
  end
end
