defmodule Mix.Tasks.Runn do
  use Mix.Task

  @shortdoc "Simply runs the Hello.say/0 function"
  def run(_) do
    # calling our Hello.say() function from earlier
    Calculationmachine.go()
    |> IO.inspect()
  end
end
