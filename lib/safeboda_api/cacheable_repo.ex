defmodule SafebodaApi.CacheableRepo do
  use NebulexEcto.Repo,
    cache: SafebodaApi.Cache,
    repo: SafebodaApi.Repo
end
