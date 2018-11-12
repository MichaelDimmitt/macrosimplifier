defmodule Mix.Tasks.Runn do
  use Mix.Task

  @shortdoc "Simply runs the Hello.say/0 function"
  def run(_) do
    # calling our Hello.say() function from earlier
    require MacroSimplifier
    MacroSimplifier.interference(2 + 1)

    CalculationMachine.go()
    |> IO.inspect()
  end
end
