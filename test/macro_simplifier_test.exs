defmodule MacroSimplifierTest do
  use ExUnit.Case

  test "simplify 2 + 1 ast" do
    require MacroSimplifier
    assert MacroSimplifier.interference(2 + 1) === [
      calc: "2 + 1",
      # line is the current line number from the MacroSimplifier. Excluding comments.
      macro: [:+, [line: 6], [2, 1]],
      simp: [:+, 2, [1]],
      op1: :+,
      values: [2, 1],
      result: 3
    ]
  end
end

