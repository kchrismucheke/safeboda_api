defmodule SafebodaApi.Helpers.Pager do
  import Ecto.Query, only: [from: 2]

  def paginate(query, page, size) do
    from(query,
      limit: ^size,
      offset: ^((page - 1) * size)
    )
  end
end
