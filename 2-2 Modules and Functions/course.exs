defmodule Course do
  @moduledoc """
    defines a course struct and function to work with courses
  """
  defstruct [name: nil, author: "Markus Mühlberger"]

  @doc """
    returns the first name of the course's author

    ## Parameters

    - course - a course struct

    ## Examples

      Course.author_firstname(%Course{author: "Some Author"})
      "Some"
  """
  def author_firstname(course) do
    course.author
    |> String.split()
    |> List.first()
  end
end
