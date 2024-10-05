defmodule Fraction do
  defstruct a: nil, b: nil

  def new(a, b), do: %Fraction{a: a, b: b}

  def value(%Fraction{a: a, b: b}), do: a / b

  def add(%Fraction{a: a, b: b}, %Fraction{a: a2, b: b2}) do
    new(
      # Denominator
      a * b2 + a2 * b,
      # Numerator
      b2 * b
    )
  end
end
