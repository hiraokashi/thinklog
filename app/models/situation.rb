class Situation < ActiveRecord::Base
  belongs_to :user
  has_many :given_time_feelings
end
