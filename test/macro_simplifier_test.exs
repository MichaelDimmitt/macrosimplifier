defmodule MacrosimplifierTest do
  use ExUnit.Case
  doctest Macrosimplifier
  doctest HygieneTest

  test "greets the world" do
    assert HygieneTest.go == :world
  end
end
