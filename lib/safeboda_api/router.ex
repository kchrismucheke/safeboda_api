defmodule SafebodaApi.Router do
  use SafebodaApi.Maru

  require Maru.Types.Datetime

  namespace :V1 do
    resource :"promo-codes" do
      desc("List All Promo Codes")

      params do
        optional(:active, type: :boolean, default: true)
        optional(:page, type: :integer, default: 1)
      end

      get do
        json(conn, SafebodaApi.Services.PromoCode.list(params[:active], params[:page]))
      end

      desc("Creates a Promo Code")

      params do
        requires(:code, type: :string)
        requires(:coupon_value, type: :integer)
        requires(:expires_at, type: :datetime)

        requires :event, type: Map do
          requires(:venue, type: :string)
          requires(:radius, type: :integer)
          requires(:lat, type: :float)
          requires(:lon, type: :float)
        end
      end

      post do
        case SafebodaApi.Services.PromoCode.create(params) do
          {:ok, promo_code} ->
            conn
            |> put_status(201)
            |> json(promo_code)

          {:error, _} ->
            conn
            |> put_status(500)
            |> text("Creation Failed")
        end
      end

      route_param :code, type: :string do
        desc("Gets a Promo Code")

        params do
          requires(:code, type: :string)
        end

        get do
          json(conn, SafebodaApi.Services.PromoCode.get(params[:code]))
        end

        desc("Updates a Promo Code")

        params do
          requires(:id, type: :integer)
          requires(:code, type: :string)
          requires(:coupon_value, type: :integer)
          requires(:expires_at, type: :datetime)

          requires :event, type: Map do
            requires(:id, type: :integer)
            requires(:venue, type: :string)
            requires(:radius, type: :integer)
          end
        end

        put do
          case SafebodaApi.Services.PromoCode.update(params) do
            {:ok, promo_code} ->
              json(conn, promo_code)

            {:error, _} ->
              conn
              |> put_status(500)
              |> text("Update Failed")
          end
        end

        desc("Deletes a Promo Code")

        params do
          requires(:code, type: :string)
        end

        delete do
          case SafebodaApi.Services.PromoCode.delete_by_code(params[:code]) do
            {:ok, response} ->
              json(conn, response)

            {:error, _} ->
              conn
              |> put_status(500)
              |> text("Delete Failed")
          end
        end

        desc("Validates a Promo Code")

        params do
          requires(:code, type: :string)
          requires(:pickup_venue, type: :string)
          requires(:destination_venue, type: :string)
        end

        get :validate do
          json(conn, SafebodaApi.Services.PromoCode.validate(params))
        end
      end
    end
  end
end
