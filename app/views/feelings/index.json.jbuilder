json.array!(@feelings) do |feeling|
  json.extract! feeling, :id, :contents
  json.url feeling_url(feeling, format: :json)
end
