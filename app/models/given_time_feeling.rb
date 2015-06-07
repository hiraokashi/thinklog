class GivenTimeFeeling < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :situation
  has_one :automatic_thought
end
