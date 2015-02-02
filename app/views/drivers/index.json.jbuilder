json.array!(@drivers) do |driver|
  json.extract! driver, :id, :name, :phone, :car_model, :lat, :lng
  json.url driver_url(driver, format: :json)
end
