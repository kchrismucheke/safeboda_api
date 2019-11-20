defmodule SafebodaApi.Repo.Migrations.AddLatitudeLongitudeFields do
  use Ecto.Migration

  def change do
    alter table("events") do
      add(:latitude, :float)
      add(:longitude, :float)
    end
  end
end
