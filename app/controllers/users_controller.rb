class UsersController < ApplicationController
  def dashboard
    @user = User.find(1)
    @situations = Situation.all.order(:created_at).reverse_order
    @situation = Situation.new
    @feelings = Feeling.all
    #@feeling_ids = @situations[0].given_time_feelings.map { |given_time_feeling| given_time_feeling.feeling.id }
    @feeling_ids = []
  end
end
