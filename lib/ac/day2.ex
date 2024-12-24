defmodule AC.Day2 do
  def load_data() do
    a =
      File.read!("priv/2024/day2.txt")
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, ~r/\s+/, trim: true))
      |> Enum.map(&Enum.map(&1, fn a -> String.to_integer(a) end))

    # |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(db)} end)

    # |> List.zip()
    # |> Enum.map(&Tuple.to_list/1)

    IO.inspect(a |> Enum.at(0))
  end
end
