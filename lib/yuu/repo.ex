defmodule Yuu.Repo do
  use Ecto.Repo,
    otp_app: :yuu,
    adapter: Ecto.Adapters.Postgres
end
