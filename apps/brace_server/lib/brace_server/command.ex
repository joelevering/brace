defmodule BraceServer.Command do

  @doc ~S"""
  Parses the given string into a command.

  ## Examples

      iex> BraceServer.Command.parse "say what up\r\n"
      {:ok, {:say, "what up"}}
  """
  def parse(line) do
    split_line = String.split(line)
    command = parse_command(split_line)
    remainder = parse_remainder(split_line)

    {:ok, {command, remainder}}
  end

  defp parse_command(split_string) do
    String.to_atom(hd(split_string))
  end

  defp parse_remainder(split_string) do
    Enum.join(tl(split_string), " ")
  end

  def run({:ok, {command, remainder}}) do
    case command do
      :say -> {:ok, "You say #{remainder}\r\n"}
      :look -> {:ok, "You stand at the base of a large ramp.\r\n"}
      _ -> {:error, "'#{command}' is not a valid command.\r\n"}
    end
  end

end
