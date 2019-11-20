defmodule SafebodaApi.SystemRouter do
  use SafebodaApi.Maru

  desc("Checks the api health status")

  get :health do
    conn
    |> json(%{status: :ok})
  end
end
