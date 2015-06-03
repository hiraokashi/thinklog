class GivenTimeFeeling < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :situation
end
