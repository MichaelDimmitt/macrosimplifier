defmodule MacroSimplifier do
  # {:*, [line: 50], [3, 3]}
  # {:+, [line: 50], [{:*, [line: 50], [3, 2]}, 1]}

  defmacro interference(macro = {op1, _, [valueOne | valueRest]}) do
    [
      calc: Macro.to_string(macro),
      macro: macro |> Tuple.to_list(),
      simp: [op1, valueOne, valueRest],
      op1: op1,
      values: [valueOne] ++ valueRest,
      result: macro
    ]
  end
end

# lib/calculation_machine.ex
defmodule AbacusClerk do
  def calculate do
    require MacroSimplifier

    #    MacroSimplifier.interference(2 + 1 * 2 + 1)
    MacroSimplifier.interference(2 + 2 * 3)
    #    MacroSimplifier.info(2+1)
  end
end
