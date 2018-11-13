defmodule MacroSimplifierTest do
  use ExUnit.Case
  require MacroSimplifier
  test "simplify ast: '2 + 2 * 3' " do
    assert MacroSimplifier.interference(2 + 2 * 3) === [
      calc: "2 + 2 * 3", macro: [:+, [line: 5], [2, 6]],
      simplified_full_macro: [:+, [2, [:*, [2, 3]]]],
      simplified_operations: [:+, :*],
      simplified_num_values: [2, 2, 3],
      result: 8
    ]
  end
  test "simplify ast: '3 * (2 + 1)' " do
    assert MacroSimplifier.interference(3 * (2 + 1)) === [
      calc: "3 * (2 + 1)",
      macro: [:*, [line: 14], [3, 3]],
      simplified_full_macro: [:*, [3, [:+, [2, 1]]]],
      simplified_operations: [:*, :+],
      simplified_num_values: [3, 2, 1],
      result: 9
    ]
  end
  test "simplify ast: '(3 * 2) + 1' " do
    assert MacroSimplifier.interference(3 * 2 + 1) === [
      calc: "3 * 2 + 1",
      macro: [:+, [line: 24], [6, 1]],
      simplified_full_macro: [:+, [[:*, [3, 2]], 1]],
      simplified_operations: [:+, :*],
      simplified_num_values: [3, 2, 1],
      result: 7
    ]
  end
  test "simplify ast: '3 * 2 + 1' )" do
    assert MacroSimplifier.interference(3 * 2 + 1) === [
      calc: "3 * 2 + 1",
      macro: [:+, [line: 34], [6, 1]],
      simplified_full_macro: [:+, [[:*, [3, 2]], 1]],
      simplified_operations: [:+, :*],
      simplified_num_values: [3, 2, 1],
      result: 7
    ]
  end
  test "simplify ast: '3 * 2 + 1 * 7 + 2 - 1 * 2' " do
    assert MacroSimplifier.interference(3 * 2 + 1 * 7 + 2 - 1 * 2) === [
      calc: "3 * 2 + 1 * 7 + 2 - 1 * 2",
      macro: [:-, [line: 44], [15, 2]],
      simplified_full_macro: [ :-,[[:+, [[:+, [[:*, [3, 2]], [:*, [1, 7]]]], 2]], [:*, [1, 2]]]],
      simplified_operations: [:-, :+, :+, :*, :*, :*],
      simplified_num_values: [3, 2, 1, 7, 2, 1, 2],
      result: 13
    ]
  end
  test "ast, weird case to investigate: '3 * 2 + 1 * 7 + 2 - 1 * 2' " do
    assert MacroSimplifier.interference(3 * 2 + 1 * 7 + 2 - 1 * 2) !== [
      calc: "3 * 2 + 1 * 7 + 2 - 1 * 2",
      macro: [:-, [line: 59], [15, 2]],
      simplified_full_macro: [:-, [:+, [:+, [:*, [3, [2]], '\a'], [2]], [2]]],
      simplified_operations: [:-, :+, :+, :*, :*, :*],
      simplified_num_values: [3, 2, 1, 7, 2, 1, 2],
      result: 13
    ]
        #      calc: "3 * 2 + 1 * 7 + 2 - 1 * 2",
        #      macro: [:-, [line: 49], [15, 2]],
        #      simplified_full_macro: [:-, [:+, [:+, [:*, [3, [2]], '\a'], [2]], [2]]],
        #      simplified_operations: [:-, :+, :+, :*],
        #      simplified_num_values: [3, [2], '\a', [2], [2]],
        #      result: 13]
  end

end
