defmodule AC.Day2 do
  def load_data() do
    File.read!("priv/2024/day2.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.split(~r/\s+/, trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp with_neighbor(l) do
    Enum.zip(l, Enum.slice(l, 1..-1//1))
  end

  defp pattern_test([h | [th | _]]) when h > th, do: &Kernel.>/2
  defp pattern_test([h | [th | _]]) when h < th, do: &Kernel.</2
  defp pattern_test(_), do: &Kernel.==/2

  def part_one(data) do
    data |> Enum.count(&safe_record/1)
  end

  defp safe_record(data_row) do
    pattern = pattern_test(data_row)
    IO.inspect(data_row, charlists: :lists)

    IO.inspect(
      data_row
      |> with_neighbor()
    )

    data_row
    |> with_neighbor()
    |> Enum.all?(fn {a, b} -> pattern.(a, b) and abs(a - b) in 1..3 end)
  end
end
