class User < ActiveRecord::Base
  has_many :situations, :dependent => :delete_all
end
