class UsersController < ApplicationController
  def dashboard
    logger.debug("user_signed_in? " + user_signed_in?.to_s)
    logger.debug("current_user " + current_user.id.to_s)
    @user = User.find(current_user.id)
    @situations = Situation.all.order(:created_at).reverse_order
    @given_time_feelings = GivenTimeFeeling.all.order(:created_at).reverse_order
    @situation = Situation.new
    @feelings = Feeling.all
    @feeling_ids = []
  end
end
