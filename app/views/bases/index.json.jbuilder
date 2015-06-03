json.array!(@bases) do |basis|
  json.extract! basis, :id, :contents, :automatic_thought_id
  json.url basis_url(basis, format: :json)
end
