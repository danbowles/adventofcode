defmodule AC.Day7 do
  alias Util.Collections
  use AC.Runner

  @impl true
  def load_data() do
    Input.load_day_input(2024, 7)
    |> Enum.map(&String.split(&1, ": "))
    |> Enum.map(fn [a, b] ->
      {
        String.to_integer(a),
        String.split(b, " ")
        |> Enum.map(&String.to_integer/1)
      }
    end)
  end

  @impl true
  def part_one(data) do
    solve_puzzle(data, false)
  end

  @impl true
  def part_two(data) do
    solve_puzzle(data, true)
  end

  def solve_puzzle(data, concat_op) do
    data
    |> Enum.chunk_every(50)
    |> Task.async_stream(fn chunk ->
      Enum.filter(chunk, fn {value, numbers} -> test_numbers?(numbers, value, concat_op) end)
      |> Collections.map_sum(&elem(&1, 0))
    end)
    |> Enum.reduce(0, fn {:ok, result}, acc -> acc + result end)
  end

  defp test_numbers?([acc | _], test_value, _) when acc > test_value, do: false
  defp test_numbers?([test_value], test_value, _), do: true
  defp test_numbers?([_], _, _), do: false

  # Part 1
  defp test_numbers?([a | [b | rest]], test_value, false) do
    test_numbers?([a + b | rest], test_value, false) or
      test_numbers?([a * b | rest], test_value, false)
  end

  defp test_numbers?([a | [b | rest]], test_value, true) do
    test_numbers?([a + b | rest], test_value, true) or
      test_numbers?([a * b | rest], test_value, true) or
      test_numbers?([String.to_integer("#{a}#{b}") | rest], test_value, true)
  end
end
