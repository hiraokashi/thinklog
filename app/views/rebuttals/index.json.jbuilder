json.array!(@rebuttals) do |rebuttal|
  json.extract! rebuttal, :id, :contents, :automatic_thought_id
  json.url rebuttal_url(rebuttal, format: :json)
end
