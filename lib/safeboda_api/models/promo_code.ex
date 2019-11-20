require Helpers.MoneyEncoder

defmodule SafebodaApi.Modules.PromoCode do
  alias SafebodaApi.Modules.PromoCode, as: PromoCode

  use Ecto.Schema

  import Ecto.SoftDelete.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  import SafebodaApi.Helpers.Pager

  @derive {Jason.Encoder, except: [:__meta__, :deleted_at]}
  schema "promo_codes" do
    field(:code, :string)
    field(:active, :boolean)
    field(:expires_at, :utc_datetime)
    field(:coupon_value, Money.Ecto.Amount.Type)
    belongs_to(:event, SafebodaApi.Modules.Event)

    timestamps(type: :utc_datetime)
    soft_delete_schema()
  end

  def all_actives(active \\ true, page \\ 1) do
    from(p in __MODULE__,
      join: e in assoc(p, :event),
      where: [active: ^active],
      order_by: [desc: :expires_at],
      preload: [event: e]
    )
    |> paginate(page, 30)
    |> SafebodaApi.Repo.all()
  end

  def get_cached_by_code(code) do
    __MODULE__
    |> SafebodaApi.CacheableRepo.get_by(code: code)
    |> SafebodaApi.Repo.preload(:event)
  end

  def create(promo_code) do
    prepare_castset(%PromoCode{}, promo_code)
    |> SafebodaApi.CacheableRepo.insert_or_update()
  end

  def update(args) do
    __MODULE__
    |> SafebodaApi.Repo.get!(args[:id])
    |> SafebodaApi.Repo.preload(:event)
    |> prepare_changeset(args)
    |> SafebodaApi.CacheableRepo.update()
  end

  def delete_by_code(code) do
    __MODULE__
    |> SafebodaApi.CacheableRepo.get_by(code: code)
    |> SafebodaApi.Cache.delete()
    |> SafebodaApi.Repo.soft_delete()
  end

  def validate(args) do
    promo_code =
      __MODULE__
      |> SafebodaApi.CacheableRepo.get_by!(code: args[:code])
      |> SafebodaApi.Repo.preload(:event)

    destination = SafebodaApi.Services.Directions.check_geolocation(args)
    polyline = SafebodaApi.Services.Directions.check_polyline(args)

    valid =
      SafebodaApi.Services.Directions.validate_boundaries(
        promo_code.event.radius,
        destination[:destination],
        {promo_code.event.latitude, promo_code.event.longitude}
      )

    Map.from_struct(promo_code)
    |> Map.pop(:__meta__)
    |> elem(1)
    |> Map.merge(destination)
    |> Map.merge(polyline)
    |> Map.merge(valid)
  end

  def prepare_castset(promo_code, attrs \\ %{}) do
    promo_code
    |> cast(attrs, [:code, :active, :expires_at, :coupon_value])
    |> validate_required([:code, :expires_at, :coupon_value])
    |> unique_constraint(:code)
    |> cast_assoc(:event)
  end

  def prepare_changeset(promo_code, attrs \\ %{}) do
    promo_code
    |> change(attrs)
    |> cast_assoc(:event)
    |> unique_constraint(:code)
    |> validate_required([:expires_at, :worths_up_to])
  end
end
