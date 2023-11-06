defmodule Games.WordleTest do
  use ExUnit.Case
  doctest Games.Wordle

  test "test all green" do
    assert Games.Wordle.feedback("aaaaa", "aaaaa") == [:green, :green, :green, :green, :green]
  end
end
