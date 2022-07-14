Geocoder.configure(
  # Geocoding options
  # timeout: 3,
  lookup: :google,              # geocoding service timeout (secs)
  # lookup: :nominatim,         # name of geocoding service (symbol)
  # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
  # language: :en,              # ISO-639 language code
  use_https: true,              # use HTTPS for lookup requests? (if supported)
  # use_https: false,           # HTTP proxy server (user:pass@host:port)
  # http_proxy: nil,
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  api_key: 'AIzaSyDaVeNmcou6666BXYFQ47BMbYWt9QGKZsw',               # API key for geocoding service
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # units: :mi,                 # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear

  # Cache configuration
  # cache_options: {
  #   expiration: 2.days,
  #   prefix: 'geocoder:'
  # }
)