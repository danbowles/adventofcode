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
end
