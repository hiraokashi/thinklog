class UsersController < ApplicationController
  def dashboard
    @user = current_user
  end

  def situations
    @user = current_user
    @situations = Situation.where(user_id: @user.id).order(:created_at).reverse_order


  end


  def given_time_feeling_summary
    #code
    @user = current_user
    @given_time_feeling = GivenTimeFeeling.find(params[:id])
  end
end
