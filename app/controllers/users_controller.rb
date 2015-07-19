class UsersController < ApplicationController
  def dashboard
    @user = current_user
  end

  def situations
    @user = current_user
    @situations = Situation.where(user_id: @user.id).order(:created_at).reverse_order


  end


  def situation_summary
    #code
    @user = current_user
    @situation = Situation.find(params[:id])
  end
end
