defmodule ACTest do
  use ExUnit.Case
  doctest AC

  test "greets the world" do
    assert AC.hello() == :world
  end
end
