class CognitiveTherapyController < ApplicationController
  def therapy_start
    # マスターデータ
    @feelings = Feeling.all
    @cognitive_distortion = CognitiveDistortion.all

    # ユーザデータ
    @situation = Situation.find(1)
    @feeling_ids = @situation.given_time_feelings.map { |given_time_feeling| given_time_feeling.feeling.id }
  end

  # 今の感情の入力テンプレートを取得する
  def add_feeling
    #situationに紐づける
    #@situation = Situation.find(params[:situation_id])
    #@given_time_feeling = GivenTimeFeeling.new
    #@automatic_thought = AutomaticThought.new
#
    #@given_time_feeling.feeling =  Feeling.find(params[:feeling_id])
    #@given_time_feeling.automatic_thought = @automatic_thought
    #@situation.given_time_feelings << @given_time_feeling

    @feeling =  Feeling.find(params[:id])

    render layout: false # レイアウトをなしにする場合
  end

  def add_automatic_thought

    @given_time_feeling = GivenTimeFeeling.find(params[:given_time_feeling_id])
    render layout: false # レイアウトをなしにする場合
  end

  # 記録する
  def save_data
    # 感情データが削除された場合、子データはすべて削除する TODO
    # 感情が作成されたら、自動思考までは作る。
    redirect_to :root
  end

  private
end
