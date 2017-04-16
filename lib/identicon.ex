defmodule Identicon do
  @moduledoc """
  Generating random identicon images based on string input
  """


  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    #We are passing back our image struct instead of an array 
    %Identicon.Image{hex: hex}
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    # Enum.filter(grid, fn(square) -> rem(x,2) == 0 end)
    #we can push a filter to a new line if needed for ease of reading
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code,2) == 0  #if no remainder return 0
    end
    %Identicon.Image{image | grid: grid }
  end
  
  #Passed through %Identicon.Image{hex: [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10] } 
  # @doc """
  # hash_input
  # ## Examples
  #     iex> image = %Identicon.Image{hex: [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10] }
  #     iex> Identicon.pick_color(image)
  #     %Identicon.Image{color: {120, 132, 40 }, hex: [120, 132, 40, 21, 36, 131, 0, 250, 106, 231, 159, 119, 118, 165, 8, 10] }
  # """
  # def pick_color(image) do
  def pick_color( %Identicon.Image{hex:  [r, g, b | _tail] } = image) do
    #assigns the hex_list array to the variable hex_list
    # %Identicon.Image{hex: hex_list} = image
    
    # [r,g,b] = hex_list  # This won't work; there are 15 inputs; not 3.    
    # This will work, we only care about the first three values and ignore the rest of the values
    # [r, g, b | _tail] = hex_list 

    #refactor - assigns r,g,b values
    # %Identicon.Image{hex:  [r, g, b | _tail] } = image

    #Assigns to the struct 'color' by using a tuple and returns the color as well as the hex for the image
    %Identicon.Image{image | color: {r,g,b} }
  end


  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)     #Enum.chunk(hex, 3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten      #Returns a flattened list [123, 132, 124]
      |> Enum.with_index   #Returns a two tupple list with the index [{123,0}, {132,1}, [124, 1]]

    grid
    %Identicon.Image{image | grid: grid}
  end


  # @doc """
  # mirror_row will mirror the row
  # ## Examples
  #     iex> image = [1,2,3]
  #     iex> mirror_row(image)
  #     [1,2,3,2,1]
  # """
  def mirror_row(row) do
    #[145,46,200] =>  [145,46,200,46,145]
    [first, second  | _tail] = row
    row ++ [second, first]
  end
end
