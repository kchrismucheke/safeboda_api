defmodule SafebodaApi.Cache do
  use Nebulex.Cache,
    otp_app: :safeboda_api,
    adapter: Nebulex.Adapters.Local
end
