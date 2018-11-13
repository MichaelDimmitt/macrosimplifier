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

  test "simplify ast: '3 * (2 + 1)' " do
    assert MacroSimplifier.interference(3 * (2 + 1)) === []
  end

  test "simplify ast: '(3 * 2) + 1' " do
    assert MacroSimplifier.interference((3*2)+1) === []
  end

  test "simplify ast: '3 * 2 + 1' )" do
    assert MacroSimplifier.interference(3*2+1) === []
  end

  test "simplify ast: '3 * 2 + 1 * 7 + 2 - 1 * 2' " do
    assert MacroSimplifier.interference(3 * 2 + 1 * 7 + 2 - 1 * 2) === []
  end
end
