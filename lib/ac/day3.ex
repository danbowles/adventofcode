defmodule AC.Day3 do
  @mul_regex ~r/mul\((\d{1,3}),(\d{1,3})\)/
  @do_regex ~r/do\(\)/
  @dont_regex ~r/don\'t\(\)/
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

  defp slice_to_int(data, {a, al}) do
    data |> String.slice(a, al) |> String.to_integer()
  end

  defp reduce_instructions({_, :do}, {acc, _}), do: {acc, :do}
  defp reduce_instructions({_, :dont}, {acc, _}), do: {acc, :dont}
  defp reduce_instructions({_, :mul, a, b}, {acc, :do}), do: {a * b + acc, :do}
  defp reduce_instructions({_, :mul, _, _}, {acc, :dont}), do: {acc, :dont}

  def part_two(data) do
    data
    |> build_mul_instructions()
    |> Enum.concat(build_dont_instructions(data))
    |> Enum.concat(build_do_instructions(data))
    |> Enum.sort(fn a, b -> a |> elem(0) < b |> elem(0) end)
    |> Enum.reduce({0, :do}, &reduce_instructions/2)
    |> elem(0)
  end

  defp build_mul_instructions(data) do
    Regex.scan(@mul_regex, data, return: :index)
    |> Enum.map(fn [{mul_idx, _}, a, b] ->
      {mul_idx, :mul, slice_to_int(data, a), slice_to_int(data, b)}
    end)
  end

  defp build_do_instructions(data) do
    Regex.scan(@do_regex, data, return: :index)
    |> Enum.map(fn [{do_idx, _}] -> {do_idx, :do} end)
  end

  defp build_dont_instructions(data) do
    Regex.scan(@dont_regex, data, return: :index)
    |> Enum.map(fn [{dont_idx, _}] -> {dont_idx, :dont} end)
  end
end
