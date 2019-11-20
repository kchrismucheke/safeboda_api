defmodule SafebodaApiTest do
  use ExUnit.Case
  doctest SafebodaApi

  test "greets the world" do
    assert SafebodaApi.hello() == :world
  end
end
