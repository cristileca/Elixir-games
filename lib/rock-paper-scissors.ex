defmodule Games.RockPaperScissors do
  def play() do
      ai = Enum.random(["rock", "paper", "scissors"])
      choice = IO.gets("Choose rock, paper, or scissors:") |> String.trim()

    cond do
      ai == choice -> "Tie"
      ai == "rock" and choice == "scissors" -> "You loose"
      ai == "rock" and choice == "paper" -> "You win"
      ai == "paper" and choice == "scissors" -> "You win"
      ai == "paper" and choice == "rock" -> "You loose"
      ai == "scissors" and choice == "paper" -> "You loose"
      ai == "scissors" and choice == "rock" -> "You win"
      true ->  "Try again, #{choice} is not an option"
    end
  end
end
