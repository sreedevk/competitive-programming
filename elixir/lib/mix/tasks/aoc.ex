defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @impl Mix.Task
  def run(["authenticate", cookie]) do
    File.write!(".cookie", cookie)
  end

  @impl Mix.Task
  def run(["init", year, day]) do
    File.mkdir_p!("data/aoc/twenty#{year}/day#{day}/")
    HTTPoison.start()
    File.write!(
      "data/aoc/twenty#{year}/day#{day}/data.txt", 
      HTTPoison.get!("https://adventofcode.com/20#{year}/day/#{day}/input", [
        Cookie: "session=#{File.read!(".cookie")}"
      ]).body
    )

    File.mkdir_p!("lib/twenty#{year}")
    File.write!(
      "lib/twenty#{year}/day#{day}.ex", 
      String.replace(String.replace(File.read!("templates/solution.ex"), "{{year}}", year), "{{day}}", day)
    )
  end

  @impl Mix.Task
  def run(["solve", year, day]) do
    IO.puts "Solving Year #{year} Day #{day}"
    IO.inspect(Aoc.solve([year, day, 1]), label: "PART 1")
    IO.inspect(Aoc.solve([year, day, 2]), label: "PART 2")
  end

  @impl Mix.Task
  def run(["solve", year, day, part]) do
    IO.inspect(Aoc.solve([year, day, String.to_integer(part)]), label: "PART #{part}")
  end

  @impl Mix.Task
  def run(["benchmark", year, day, part]) do
    Benchee.run(
      %{
        "YEAR: #{year}| DAY: #{day} | PART: #{part}" => fn -> Aoc.solve([year, day, String.to_integer(part)]) end
      },
      parallel: 8,
      formatters: [
        { Benchee.Formatters.Console, extended_statistics: true },
        { Benchee.Formatters.HTML, file: "benchmarks/year_#{year}_day__#{day}.html" }
      ]
    )
  end

  @impl Mix.Task
  def run(["benchmark", year, day]) do
    Benchee.run(
      %{
        "YEAR: #{year}| DAY: #{day} | PART: 1" => fn -> Aoc.solve([year, day, 1]) end,
        "YEAR: #{year}| DAY: #{day} | PART: 2" => fn -> Aoc.solve([year, day, 2]) end
      },
      parallel: 8,
      formatters: [
        { Benchee.Formatters.Console, extended_statistics: true },
        { Benchee.Formatters.HTML, file: "benchmarks/year_#{year}_day__#{day}.html" }
      ]
    )
  end

  @impl Mix.Task
  def run(_) do
    IO.puts("INVALID ARGS!")
    IO.puts("USAGE   [AUTH]: mix aoc authenticate <cookie>")
    IO.puts("USAGE   [INIT FILES]: mix aoc init <year> <day>")
    IO.puts("USAGE   [SOLVE]: mix aoc solve <YY> <D> [<PART>]")
    IO.puts("EXAMPLE [SOLVE]: mix aoc solve 21 1 1")
  end
end
