json.array!(@co_independent_traits) do |co_independent_trait|
  json.extract! co_independent_trait, :id, :contents
  json.url co_independent_trait_url(co_independent_trait, format: :json)
end
