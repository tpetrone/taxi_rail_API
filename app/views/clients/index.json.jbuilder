json.array!(@clients) do |client|
  json.extract! client, :id, :name, :phone, :lat, :lng
  json.url client_url(client, format: :json)
end
