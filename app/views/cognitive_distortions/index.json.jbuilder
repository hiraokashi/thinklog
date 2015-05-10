json.array!(@cognitive_distortions) do |cognitive_distortion|
  json.extract! cognitive_distortion, :id, :question, :name
  json.url cognitive_distortion_url(cognitive_distortion, format: :json)
end
