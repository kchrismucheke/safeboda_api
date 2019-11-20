defmodule SafebodaApi.Maru do
  use Maru.Server, otp_app: :safeboda_api

  def init(_type, opts) do
    Confex.Resolver.resolve(opts)
  end
end
