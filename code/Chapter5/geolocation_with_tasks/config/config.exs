use Mix.Config

config :geolix,
  databases: [
    { :country, "./geo_db/GeoLite2-Country.mmdb" }
  ]
