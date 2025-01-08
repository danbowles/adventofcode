defmodule AC.Runner do
  @callback load_data() :: any
  @callback part_one(data :: any) :: any
  @callback part_two(data :: any) :: any

  defmacro __using__(_opts) do
    quote do
      alias Util.Input

      @behaviour AC.Runner

      def run_part_one() do
        load_data() |> part_one()
      end

      def run_part_two() do
        load_data() |> part_two()
      end
    end
  end
end
