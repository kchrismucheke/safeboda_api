defmodule SafebodaApi.Repo.Migrations.CreatePromoCodes do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:events) do
      add(:name, :string)
      add(:venue, :string, null: false)
      add(:radius, :integer, null: false)

      timestamps(type: :timestamptz)
      soft_delete_columns()
    end

    create table(:promo_codes) do
      add(:code, :string, null: false)
      add(:active, :boolean, default: true)
      add(:expires_at, :utc_datetime, null: false)
      add(:coupon_value, :integer, null: false)
      add(:event_id, references(:events))

      timestamps(type: :timestamptz)
      soft_delete_columns()
    end

    create(unique_index(:promo_codes, [:code]))
  end
end
