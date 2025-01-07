defmodule AC.Day4 do
  @grid_dirs [
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, -1},
    {0, 1},
    {1, -1},
    {1, 0},
    {1, 1}
  ]

  def load_data() do
    Util.Input.load_day_input(2024, 4)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> then(&build_grid/1)
  end

  defp build_grid(data) do
    rows = length(data)
    cols = data |> Enum.at(0) |> length()

    {
      Enum.reduce(0..(rows - 1), %{}, fn row, acc_grid ->
        Map.new(0..(cols - 1), fn col ->
          {
            {row, col},
            data |> Enum.at(row) |> Enum.at(col)
          }
        end)
        |> then(&Map.merge(acc_grid, &1))
      end),
      rows,
      cols
    }
  end

  def part_one({grid, _, _}) do
    grid
    |> Enum.filter(fn {_, value} -> value == "X" end)
    |> Enum.map(fn cell ->
      {r, c} = elem(cell, 0)

      for {dirR, dirC} <- @grid_dirs do
        0..3
        |> Enum.map(fn char ->
          {r + dirR * char, c + dirC * char}
        end)
        |> Enum.map_join(fn {r, c} ->
          Map.get(grid, {r, c}, "")
        end)
      end
      |> Enum.count(fn item -> item == "XMAS" end)
    end)
    |> Enum.sum()
  end
end
