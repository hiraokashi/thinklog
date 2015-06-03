json.array!(@automatic_thoughts) do |automatic_thought|
  json.extract! automatic_thought, :id, :contents, :given_time_feeling_id
  json.url automatic_thought_url(automatic_thought, format: :json)
end
