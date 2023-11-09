defmodule Games do
  def main(ags \\ []) do
    hello()
  end

  def hello do
    option = IO.gets("What game would you like to play?
    1. Guessing Game
    2. Rock Paper Scissors
    3. Wordle

    Enter your option: ") |> String.trim()

    cond do
      option == "stop" -> "We are sorry we don't have a game that suits you!"
      String.to_integer(option)  == 1 -> Games.GuessingGame.play()
      String.to_integer(option)  == 2 -> Games.RockPaperScissors.play()
      String.to_integer(option)  == 3 -> Games.Wordle.play()
      true -> "That is not an option"
    end
  end
end
