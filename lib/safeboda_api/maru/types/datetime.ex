defmodule Maru.Types.Datetime do
  use Maru.Type

  def arguments do
    [:datetime]
  end

  def parse(input, _) do
    {:ok, datetime, 0} = DateTime.from_iso8601(input)
    DateTime.truncate(datetime, :second)
  end
end
