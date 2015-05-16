json.array!(@adult_children_traits) do |adult_children_trait|
  json.extract! adult_children_trait, :id, :contents
  json.url adult_children_trait_url(adult_children_trait, format: :json)
end
