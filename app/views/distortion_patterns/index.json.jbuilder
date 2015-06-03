json.array!(@distortion_patterns) do |distortion_pattern|
  json.extract! distortion_pattern, :id, :cognitive_distortion_id, :distortion_pattern
  json.url distortion_pattern_url(distortion_pattern, format: :json)
end
