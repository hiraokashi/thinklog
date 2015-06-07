class AutomaticThought < ActiveRecord::Base
  belongs_to :given_time_feeling
  has_many :distortion_patterns
end
