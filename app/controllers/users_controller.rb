class UsersController < ApplicationController
  def dashboard
    @user = current_user
  end

  def mood_monitor
    #code
    @user = current_user
    @recent_situation = Situation.where(user_id: @user.id).last
    @situations_today = Situation.where(user_id: @user.id).today.order('updated_at ASC')
    @mood_chart_data = Situation.mood_chart_data(@situations_today)

    # 今日の気分のグラフ
    @mood_stacked_datalabels = @mood_chart_data[0].keys # 全部同じものが入っているので、代表一つからとればいい
    # logger.debug(@mood_stacked_datalabels)

    # 気分のうちわけ
    @mood_counts = Situation.mood_counts(@user)

    # 実行中のステータス別（棒グラフ）
    #@feeling_status_counts = GivenTimeFeeling.count_up_status(@user)

    # 感情の構成比（パイチャート）
    @feeling_counts = GivenTimeFeeling.count_up_feeling(@user)


  end

  def situations
    @user = current_user
    # @situations = Situation.where(user_id: @user.id).order(:updated_at).reverse_order
    @situations_negative = Situation.where(user_id: @user.id).negative.order(:updated_at).reverse_order


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
