defmodule MacroSimplifier do

  # {:*, [line: 50], [3, 3]}
  # {:+, [line: 50], [{:*, [line: 50], [3, 2]}, 1]}

  ## goal
  ## defmacro interference(macro = {op1, _, [valueOne | valueRest]}) do
  ##   [ calc: Macro.to_string(macro),
  ##     macro: macro |> Tuple.to_list,
  ##     simp: [op1, valueOne, valueRest],
  ##     op1: op1,
  ##     values: [valueOne] ++ valueRest,
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

  def simplify(macro = {op1, _, list = [valueOne | valueRest]}) do
    [op1, list, valueOne, valueRest]
    [entire_simp: simplify_entire(macro)]
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
