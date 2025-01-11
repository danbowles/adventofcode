defmodule Mix.Tasks.CreateDay do
  use Mix.Task

  @lib_dir Path.join(File.cwd!(), "lib/ac")
  @priv_dir Path.join(File.cwd!(), "priv")

  # TODO: make this work for multiple years

  def run([]) do
    raise "Please provide a day and a year"
  end

  def run([year, day]) do
    create_day(year, day)
  end

  def create_day(year, day) do
    create_code(day)
    create_data(year, day)
  end

  def create_code(day) do
    file_path = Path.join([@lib_dir, "day#{day}.ex"])
    File.write!(file_path, code(day))
  end

  defp code(day) do
    """
    defmodule AC.Day#{day} do
      use AC.Runner

      @impl true
      def load_data() do
        Input.load_day_input(2024, #{day})
      end

      @impl true
      def part_one(_data) do
        :not_implemented
      end

      @impl true
      def part_two(_data) do
        :not_implemented
      end
    end
    """
  end

  def create_data(year, day) do
    file_path = Path.join([@priv_dir, year, "day#{day}.txt"])
    File.touch!(file_path)
  end
end
