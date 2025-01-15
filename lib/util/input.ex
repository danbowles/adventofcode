defmodule Util.Input do
  def load_day_input(year, day, split) do
    priv_dir = :code.priv_dir(:adventofcode)

    Path.join([
      priv_dir,
      year |> Integer.to_string(),
      "day#{day}.txt"
    ])
    |> File.read!()
    |> String.split(split, trim: true)
  end

  def load_day_input(year, day), do: load_day_input(year, day, "\n")

  defp build_grid(data) do
    rows = length(data)
    cols = data |> Enum.at(0) |> length()

    grid = {
      Enum.reduce(0..(rows - 1), %{}, fn row, acc_grid ->
        Map.new(0..(cols - 1), fn col ->
          {
            {row, col},
            data |> Enum.at(row) |> Enum.at(col)
          }
        end)
        |> then(&Map.merge(acc_grid, &1))
      end)
    }

    {grid, rows, cols}
  end

  def as_grid(data) do
    data
    |> Enum.map(&String.split(&1, "", trim: true))
    |> then(&build_grid/1)
  end
end
