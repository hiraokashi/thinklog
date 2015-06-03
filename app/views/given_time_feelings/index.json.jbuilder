json.array!(@given_time_feelings) do |given_time_feeling|
  json.extract! given_time_feeling, :id, :feeling_id, :situation_id
  json.url given_time_feeling_url(given_time_feeling, format: :json)
end
