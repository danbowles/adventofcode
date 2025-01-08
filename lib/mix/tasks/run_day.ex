defmodule Mix.Tasks.RunDay do
  use Mix.Task

  def run([]) do
    raise "Please provide a day and a year"
  end

  def run([year, day]) do
    {year, day}
    |> tap(&run_part_one(&1 |> elem(0), &1 |> elem(1)))
    |> tap(&run_part_two(&1 |> elem(0), &1 |> elem(1)))
  end

  def run([year, day, "1"]) do
    {year, day}
    |> tap(&run_part_one(&1 |> elem(0), &1 |> elem(1)))
  end

  def run([year, day, "2"]) do
    {year, day}
    |> tap(&run_part_two(&1 |> elem(0), &1 |> elem(1)))
  end

  defp run_part_one(year, day) do
    IO.puts("--------------------")
    IO.puts("🏃 Running part one (1) for year #{year} day #{day}")
    module = "Elixir.AC.Day#{day}"
    start_at = :os.system_time(:millisecond)
    result = apply(String.to_atom(module), :run_part_one, [])
    end_at = :os.system_time(:millisecond)
    IO.puts("✨ Result: #{result}")
    IO.puts("🏁 Finished in #{end_at - start_at}ms")
  end

  defp run_part_two(year, day) do
    IO.puts("--------------------")
    IO.puts("🏃 Running part two (2) for year #{year} day #{day}")
    module = "Elixir.AC.Day#{day}"
    start_at = :os.system_time(:millisecond)
    result = apply(String.to_atom(module), :run_part_two, [])
    end_at = :os.system_time(:millisecond)
    IO.puts("✨ Result: #{result}")
    IO.puts("🏁 Finished in #{end_at - start_at}ms")
  end
end
