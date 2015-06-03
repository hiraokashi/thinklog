json.array!(@situations) do |situation|
  json.extract! situation, :id, :when, :where, :with_whom, :what_have_you_been_doing, :user_id
  json.url situation_url(situation, format: :json)
end
