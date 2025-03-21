defmodule AC.Day4 do
  use AC.Runner

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
    Input.load_day_input(2024, 4)
    |> Input.as_grid()
  end

  def part_one({grid, _, _}) do
    grid
    |> Enum.filter(fn {_, value} -> value == "X" end)
    |> Enum.map(fn {rc, _} -> map_xmas_count(grid, rc) end)
    |> Enum.sum()
  end

  defp map_xmas_count(grid, {r, c}) do
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
  end

  def part_two({grid, _, _}) do
    grid
    |> Enum.filter(fn {_, value} -> value == "A" end)
    |> Enum.count(fn {coord, _} -> map_x_mas(grid, coord) end)
  end

  defp map_x_mas(grid, {r, c}) do
    [tl, tr, bl, br] =
      [{-1, -1}, {-1, 1}, {1, -1}, {1, 1}]
      |> Enum.map(fn {dirR, dirC} ->
        {r + dirR, c + dirC}
      end)
      |> Enum.map(fn {r, c} ->
        Map.get(grid, {r, c}, "")
      end)

    ([tl, br] == ["M", "S"] or
       [tl, br] == ["S", "M"]) and
      ([tr, bl] == ["M", "S"] or [tr, bl] == ["S", "M"])
  end
end
