json.array!(@adaptive_thoughts) do |adaptive_thought|
  json.extract! adaptive_thought, :id, :contents, :automatic_thought_id
  json.url adaptive_thought_url(adaptive_thought, format: :json)
end
