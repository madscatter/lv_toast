defmodule LvToastWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :lv_toast

  @session_options [
    store: :cookie,
    key: "_lv_toast_key",
    signing_salt: "+bPbPpNV"
  ]

  socket "/socket", LvToastWeb.UserSocket,
    websocket: [timeout: 45_000],
    longpoll: false

  socket "/live", Phoenix.LiveView.Socket,
         websocket: [connect_info: [session: @session_options, timeout: 45_000]]


  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :lv_toast,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session, @session_options

  plug LvToastWeb.Router
end
