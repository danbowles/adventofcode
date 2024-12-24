# Advent of Code in Elixir

To run:
```
mix deps.get
iex -S mix
```

While in IEX:
```
alias AC.Day1
Day1.load_data() |> Day1.part_one()
```

Pretty...not great way to run it, but hope to improve as this keeps going

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `adventofcode` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:adventofcode, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/adventofcode>.

