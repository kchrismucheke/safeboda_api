defmodule Helpers.MoneyEncoder do
  require Protocol
  Protocol.derive(Jason.Encoder, Money, only: [:amount, :currency])
end
