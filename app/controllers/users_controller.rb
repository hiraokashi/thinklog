class UsersController < ApplicationController
  def dashboard
    @user = User.find(1)
    @situations = Situation.all.order(:created_at).reverse_order
    @given_time_feelings = GivenTimeFeeling.all.order(:created_at).reverse_order
    @situation = Situation.new
    @feelings = Feeling.all
    @feeling_ids = []
  end
end
