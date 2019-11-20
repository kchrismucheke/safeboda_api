defmodule SafebodaApi.API do
  use SafebodaApi.Maru

  plug(Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Jason,
    parsers: [:json]
  )

  mount(SafebodaApi.SystemRouter)

  before do
    plug(SafebodaApi.Auth, at: "/V1")

    mount(SafebodaApi.Router)
  end
end
