defmodule AC.Day6 do
  use AC.Runner

  @start_char "^"
  @dir_enum [
    {-1, 0},
    {0, 1},
    {1, 0},
    {0, -1}
  ]

  @impl true
  def load_data() do
    Input.load_day_input(2024, 6)
    |> Input.as_grid()
    |> then(fn {grid, _, _} ->
      {start, _} = grid |> Enum.find(fn {_, value} -> value == @start_char end)
      {grid, start}
    end)
  end

  @impl true
  def part_one({grid, start}) do
    walk_guard(grid, 0, start, MapSet.new())
    |> MapSet.size()
  end

  defp walk_guard(grid, dir_idx, {r, c}, acc_mapset) do
    {cur_dr, cur_dc} = @dir_enum |> Enum.at(dir_idx)
    next_dir_idx = rem(dir_idx + 1, length(@dir_enum))

    case Map.get(grid, {r + cur_dr, c + cur_dc}, nil) do
      nil ->
        acc_mapset |> MapSet.put({r, c})

      char when char == "." or char == "^" ->
        walk_guard(
          grid,
          dir_idx,
          {r + cur_dr, c + cur_dc},
          MapSet.put(acc_mapset, {r, c})
        )

      _ ->
        walk_guard(grid, next_dir_idx, {r, c}, acc_mapset)
    end
  end

  @impl true
  def part_two(_data) do
    :not_implemented
  end
end
