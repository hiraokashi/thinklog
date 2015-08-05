class UsersController < ApplicationController
  def dashboard
    @user = current_user
  end

  def situations
    @user = current_user
    # @situations = Situation.where(user_id: @user.id).order(:updated_at).reverse_order
    @recent_situation = Situation.where(user_id: @user.id).last
    @situations = Situation.where(user_id: @user.id).negative.order(:updated_at).reverse_order
  end

  def given_time_feeling_summary
    # code
    @user = current_user
    @given_time_feeling = GivenTimeFeeling.find(params[:id])

    # 感情の推移棒グラフのデータセット構築
    @feeling_series_datalabels = {}
    @feeling_series_datalabels[:label1] = 'ステップ1'
    @feeling_series_datalabels[:label2] = 'ステップ2' if @given_time_feeling.executed_step2?
    @feeling_series_datalabels[:label3] = 'ステップ3' if @given_time_feeling.executed_step3?
    @feeling_series_datalabels[:label4] = 'ステップ4' if @given_time_feeling.executed_step4?
    @feeling_series_datapoints = {}
    @feeling_series_datapoints[:data1] = @given_time_feeling.step1_percentage
    @feeling_series_datapoints[:data2] = @given_time_feeling.step2_percentage if @given_time_feeling.executed_step2?
    @feeling_series_datapoints[:data3] = @given_time_feeling.step3_percentage if @given_time_feeling.executed_step3?
    @feeling_series_datapoints[:data4] = @given_time_feeling.step4_percentage if @given_time_feeling.executed_step4?
  end
end
