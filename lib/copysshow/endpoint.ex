defmodule Copysshow.Endpoint do
  use Phoenix.Endpoint, otp_app: :copysshow

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :copysshow,
    only: ~w(css images js favicon.ico robots.txt fonts)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_copysshow_key",
    signing_salt: "0RwsRHFZ",
    encryption_salt: "jWaWg8Yi"

  plug :router, Copysshow.Router
end
