defmodule Games.GuessingGame do
  @spec play() :: <<_::64, _::_*8>>
  def play() do
    {guess, _} = IO.gets("Guess a number between 1 and 10:") |> Integer.parse()
    num = Enum.random([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    acc = 1

    cond do
      guess == num -> "You win!"
      guess > num -> guess_smaller(num, acc + 1)
      guess < num -> guess_bigger(num, acc + 1)
    end
  end

  defp guess_smaller(num, acc) do
    IO.puts("Too High!")

    finish(num, acc)
  end

  defp guess_bigger(num, acc) do
    IO.puts("Too Low!")

    finish(num, acc)
  end

  defp finish(num, acc) do
    {guess, _} = IO.gets("Guess a number between 1 and 10:") |> Integer.parse()

    cond do
      guess != num and acc > 5 -> "You lose! the answer was #{num}"
      guess == num and acc <= 5 -> "You win!"
      guess > num -> guess_smaller(num, acc + 1)
      guess < num -> guess_bigger(num, acc + 1)
    end
  end
  
end
