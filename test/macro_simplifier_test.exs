defmodule MacroSimplifierTest do
  use ExUnit.Case
  require MacroSimplifier

  test "simplify ast: '2 + 2 * 3' " do
    assert MacroSimplifier.interference(2 + 2 * 3) === [
      simplified_full_macro: [:+, [2, [:*, [2, 3]]]],
      simplified_operations: [:+, :*],
      simplified_num_values: [2, 2, 3]
    ]
  end

end
