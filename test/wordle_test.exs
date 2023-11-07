defmodule Games.WordleTest do
  use ExUnit.Case
  doctest Games.Wordle

  test "test all green" do
    assert Games.Wordle.feedback("aaaaa", "aaaaa") == [:green, :green, :green, :green, :green]
  end

  test "test all collors" do
    assert Games.Wordle.feedback("XXXAA", "AAAAY") == [:yellow, :grey, :grey, :green, :grey]
  end

  test "test all yellow" do
    assert Games.Wordle.feedback("abdce", "edcba") == [
             :yellow,
             :yellow,
             :yellow,
             :yellow,
             :yellow
           ]
  end

  test "test all grey" do
    assert Games.Wordle.feedback("aaaaa", "bbbbb") == [:grey, :grey, :grey, :grey, :grey]
  end
end
