defmodule MacroSimplifier do
  # {:*, [line: 50], [3, 3]}
  # {:+, [line: 50], [{:*, [line: 50], [3, 2]}, 1]}

  ## goal
  ## defmacro interference(macro = {op1, _, [valueOne | valueRest]}) do
  ##   [ calc: Macro.to_string(macro),
  ##     macro: macro |> Tuple.to_list,
  ##     simp: simplify(macro, full),
  ##     op1: simplify(macro, operations),
  ##     values: simplify(macro, values),
  ##     result: macro
  ##   ]

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

  def simplify_operations(atom) do
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

  def simplify(macro = {op1, _, list = [valueOne | valueRest]}) do
    [op1, list, valueOne, valueRest]

    [
      simplified_full_macro: simplify_entire(macro),
      simplified_operations: simplify_operations(macro),
      simplified_num_values: simplify_values(macro)
    ]
  end

  defmacro interference(macro = {op1, _, [valueOne | valueRest]}) do
    [op1, valueOne, valueRest]
    # macro  |> exampleStillHaveTheQuotedValue()
    # |> IO.inspect

    macro
    |> simplify
  end
end

# lib/calculation_machine.ex
defmodule AbacusClerk do

  def calculate do
    require MacroSimplifier

    #    MacroSimplifier.interference(2 + 1 * 2 + 1)
    MacroSimplifier.interference((2) + 2 * 3)
    #    MacroSimplifier.info(2+1)
  end
end
