defmodule Identicon do
  @moduledoc """
  Generating random identicon images based on string input
  """

  @doc """
  main
  ## Examples

      iex> Identicon.main("jonathan")
      [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10]
  """
  def main(input) do
    input
    |> hash_main
  end

  @doc """
  hash_main
  ## Examples

      iex> Identicon.hash_main("jonathan")
      [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10]
  """
  def hash_main(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list    
  end
end
