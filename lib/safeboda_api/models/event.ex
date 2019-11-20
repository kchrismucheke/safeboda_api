defmodule SafebodaApi.Modules.Event do
  use Ecto.Schema

  import Ecto.SoftDelete.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__, :promo_codes, :deleted_at]}
  schema "events" do
    field(:name, :string)
    field(:venue, :string)
    field(:radius, :integer)
    field(:latitude, :float)
    field(:longitude, :float)

    has_many(:promo_codes, SafebodaApi.Modules.PromoCode)

    timestamps(type: :utc_datetime)
    soft_delete_schema()
  end

  def changeset(event, attrs \\ %{}) do
    event
    |> cast(attrs, [:name, :venue, :radius, :latitude, :longitude])
    |> validate_required([:venue, :radius, :latitude, :longitude])
  end
end
