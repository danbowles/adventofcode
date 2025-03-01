defmodule AC.Day6 do
  use AC.Runner
  alias Util.Collections

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

  @impl true
  def part_two({grid, start}) do
    walk_guard(grid, 0, start, MapSet.new())
    |> MapSet.to_list()
    |> Enum.chunk_every(20)
    |> Task.async_stream(fn chunk ->
      Collections.map_sum(chunk, fn coord ->
        walk_guard_for_sum(grid |> Map.put(coord, "#"), 0, start, MapSet.new())
      end)
    end)
    |> Enum.reduce(0, fn {:ok, result}, acc -> result + acc end)
    |> Kernel.-(1)
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

  defp walk_guard_for_sum(grid, dir_idx, {r, c}, acc_mapset) do
    {cur_dr, cur_dc} = @dir_enum |> Enum.at(dir_idx)
    next_dir_idx = rem(dir_idx + 1, length(@dir_enum))

    if MapSet.member?(acc_mapset, {dir_idx, r + cur_dr, c + cur_dc}) do
      1
    else
      case Map.get(grid, {r + cur_dr, c + cur_dc}, nil) do
        nil ->
          0

        char when char == "." or char == "^" ->
          walk_guard_for_sum(
            grid,
            dir_idx,
            {r + cur_dr, c + cur_dc},
            MapSet.put(acc_mapset, {dir_idx, r, c})
          )

        _ ->
          walk_guard_for_sum(grid, next_dir_idx, {r, c}, MapSet.put(acc_mapset, {dir_idx, r, c}))
      end
    end
  end
end
