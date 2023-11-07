defmodule Games.Wordle do
   @moduledoc """
   Documentation for `Games.Wordle`
   """
   @words [
     "banane",
     "masina",
     "elixir",
     "twilio"
   ]
   @type color :: :green | :grey | :yellow
   @type colors :: [color]


   @spec play(String.t() | nil, integer()) :: :ok
   def play(answer \\ nil, attempt \\ 1) do
     answer = answer || Enum.random(@words)
     guess = IO.gets("Guess a five-letter word: ") |> String.trim()

     cond do
       answer == guess ->
         IO.puts("You win!")

       attempt == 6 ->
         IO.puts("You lose! The answer was #{answer}!")

       true ->
         feedback(answer, guess)
         |> colored_feedback(guess)
         |> IO.puts()

         play(answer, attempt + 1)
     end
   end


   @spec colored_feedback(colors(), String.t()) :: String.t()
   def colored_feedback(colors, guess) do
     colored_text =
       Enum.zip(colors, String.split(guess, "", trim: true))
       |> Enum.map(fn
         {:green, char} -> IO.ANSI.green() <> char
         {:yellow, char} -> IO.ANSI.yellow() <> char
         {:grey, char} -> IO.ANSI.light_black() <> char
       end)
       |> Enum.join("")

     colored_text <> IO.ANSI.reset()
   end


   @spec feedback(String.t(), String.t()) :: colors()
   def feedback(answer, guess) do
     split_answer = String.split(answer, "", trim: true)
     split_guess = String.split(guess, "", trim: true)

     {split_answer, split_guess}
     |> replace_greens()
     |> replace_yellows()
     |> replace_greys()
     |> elem(1)
   end

   @spec replace_greens({list(), list()}) :: {list(), list()}
   defp replace_greens({answer, guess}) do
     Enum.zip(answer, guess)
     |> Enum.map(fn
       {same, same} ->
         {nil, :green}

       non_green ->
         non_green
     end)
     |> Enum.unzip()
   end

   @spec replace_yellows({list(), list()}) :: {list(), list()}
   defp replace_yellows({answer, guess}) do
     Enum.reduce(guess, {answer, guess}, fn
       guess_char, {answer_acc, guess_acc} ->
         answer_index =
           Enum.find_index(answer_acc, fn answer_char -> answer_char == guess_char end)

         guess_index = Enum.find_index(guess_acc, fn char -> char == guess_char end)

         if answer_index do
           updated_answer_acc = List.replace_at(answer_acc, answer_index, nil)
           updated_guess_acc = List.replace_at(guess_acc, guess_index, :yellow)
           {updated_answer_acc, updated_guess_acc}
         else
           {answer_acc, guess_acc}
         end
     end)
   end

   @spec replace_greys({list(), list()}) :: {list(), list()}
   defp replace_greys({answer, guess}) do
     Enum.zip(answer, guess)
     |> Enum.map(fn
       {_, :green} ->
         {nil, :green}

       {_, :yellow} ->
         {nil, :yellow}

       _ ->
         {nil, :grey}
     end)
     |> Enum.unzip()
   end
 end
