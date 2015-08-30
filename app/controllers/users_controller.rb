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

  #気分が登録されたらグラフを更新する
  def update_monitor_chart
    @user = current_user
    mood_count =  Situation.mood_counts(@user)

    situations_today = Situation.where(user_id: @user.id).today.order('updated_at ASC')
    mood_chart_data = Situation.mood_chart_data(situations_today)
    mood_stacked_datalabels =mood_chart_data[0].keys
    mood_chart_data.map!{|datapoints| datapoints.values}

    update_data = {mood_count: mood_count,
                   mood_chart_data: mood_chart_data,
                   mood_stacked_datalabels: mood_stacked_datalabels
                  }

    render :json => update_data

  end

  def situations
    @user = current_user
    # @situations = Situation.where(user_id: @user.id).order(:updated_at).reverse_order
    @situations_negative = Situation.where(user_id: @user.id).negative.order(:created_at).reverse_order


  end

  def given_time_feeling_summary
    # code
    #このメソッドは未使用
  end
end
