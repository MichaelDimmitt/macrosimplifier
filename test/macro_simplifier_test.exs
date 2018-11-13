defmodule MacroSimplifierTest do
  use ExUnit.Case
  require MacroSimplifier

  test "simplify ast: '2 + 2 * 3' " do
    assert MacroSimplifier.interference(2 + 2 * 3) === [
      simplified_full_macro: [:+, [2, [:*, [2, 3]]]],
      simplified_operations: [:+, :*]
    ]
  end

  test "simplify ast: '3 * (2 + 1)' " do
    assert MacroSimplifier.interference(3 * (2 + 1)) === [
      simplified_full_macro: [:*, [3, [:+, [2, 1]]]],
      simplified_operations: [:*, :+]
    ]
  end

  test "simplify ast: '(3 * 2) + 1' " do
    assert MacroSimplifier.interference((3*2)+1) === [
      simplified_full_macro: [:+, [[:*, [3, 2]], 1]],
      simplified_operations: [:+, :*]
    ]
  end

  test "simplify ast: '3 * 2 + 1' )" do
    assert MacroSimplifier.interference(3*2+1) === [
      simplified_full_macro: [:+, [[:*, [3, 2]], 1]],
      simplified_operations: [:+, :*]
    ]
  end

  test "simplify ast: '3 * 2 + 1 * 7 + 2 - 1 * 2' " do
    assert MacroSimplifier.interference(3 * 2 + 1 * 7 + 2 - 1 * 2) === [
      simplified_full_macro: [:-, [[:+, [[:+, [[:*, [3, 2]], [:*, [1, 7]]]], 2]], [:*, [1, 2]]]],
      simplified_operations: [:-, :+, :+, :*, :*, :*]
    ]

  end
end
