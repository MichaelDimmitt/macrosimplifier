
defmodule Macrosimplifier do
  def hello do
    :world
  end
  # {:*, [line: 50], [3, 3]}
  # {:+, [line: 50], [{:*, [line: 50], [3, 2]}, 1]}

  defmacro interference(a_str, macro, {op1, _, [valueOne | valueRest]}) do
    IO.inspect binding()
  end

end

defmodule Calculationmachine do
  def go do
    require Macrosimplifier
    Macrosimplifier.interference('2+1', 2+1, 2+1)
  end
end