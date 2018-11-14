defmodule MacroSimplifier do
  # {:*, [line: 50], [3, 3]}
  # {:+, [line: 50], [{:*, [line: 50], [3, 2]}, 1]}

  def simplify_entire({opNext, _, [head | tail]}) do
    [opNext, [simplify_entire(head), simplify_entire(tail)]]
  end

  def simplify_entire([atomOrTuple]) do
    simplify_entire(atomOrTuple)
  end

  def simplify_entire(atom) do
    atom
  end

  def simplify_operations({opNext, _, [head | tail]}) do
    [opNext] ++ simplify_operations(head) ++ simplify_operations(tail)
  end

  def simplify_operations([atomOrTuple]) do
    simplify_operations(atomOrTuple)
  end

  def simplify_operations(_) do
    []
  end

  def simplify_values({_, _, [head | tail]}) do
    simplify_values(head) ++ simplify_values(tail)
  end

  def simplify_values([atomOrTuple]) do
    simplify_values(atomOrTuple)
  end

  def simplify_values(atom) do
    [atom]
  end

  def simplify(macro = {_op1, _scope, _list = [_valueOne | _valueRest]}) do
    [
      calc: Macro.to_string(macro),
      macro: macro |> Tuple.to_list(),
      simplified_full_macro: simplify_entire(macro),
      simplified_operations: simplify_operations(macro),
      simplified_num_values: simplify_values(macro),
      result: macro
    ]
  end

  defmacro interference(macro = {_op1, _scope, [_valueOne | _valueRest]}) do
    macro
    |> simplify
  end
end

# lib/calculation_machine.ex
defmodule AbacusClerk do
  def calculate do
    require MacroSimplifier
    MacroSimplifier.interference(2 + 2 * 3)
  end
end
