defmodule Identicon do
  @moduledoc """
  Generating random identicon images based on string input
  """

  @doc """
  main
  ## Examples

      iex> Identicon.main("jonathan")
      %Identicon.Image{color: {120, 132, 40 }, hex: [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10] }
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  @doc """
  hash_input
  ## Examples

      iex> Identicon.hash_input("jonathan")
      %Identicon.Image{hex: [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10] }
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    #We are passing back our image struct instead of an array 
    %Identicon.Image{hex: hex}
  end
  #Passed through %Identicon.Image{hex: [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10] }


  
  @doc """
  hash_input
  ## Examples
      iex> image = %Identicon.Image{hex: [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10] }
      iex> Identicon.pick_color(image)
      %Identicon.Image{color: {120, 132, 40 }, hex: [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10] }
  """
  # def pick_color(image) do
  def pick_color( %Identicon.Image{hex:  [r, g, b | _tail] } = image) do
    #assigns the hex_list array to the variable hex_list
    # %Identicon.Image{hex: hex_list} = image
    
    # [r,g,b] = hex_list  # This won't work; there are 15 inputs; not 3.    
    # This will work, we only care about the first three values and ignore the rest of the values
    # [r, g, b | _tail] = hex_list 

    #refactor - assigns r,g,b values
    # %Identicon.Image{hex:  [r, g, b | _tail] } = image

    #Assigns to the struct 'color' by using a tuple
    %Identicon.Image{image | color: {r,g,b} }
  end
end
