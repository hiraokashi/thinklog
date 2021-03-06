class TopController < ApplicationController
  def index
    @home = true
    @cognitive_distortions = CognitiveDistortion.all
    @feelings = Feeling.all

    @situation = Situation.new
    @feeling_ids = @situation.given_time_feelings.map { |given_time_feeling| given_time_feeling.feeling.id }

    #診断の一問目はここで


    remote_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
    session[remote_ip] = {}
    session[remote_ip]['question_list'] = []

    @adult_children_trait = AdultChildrenTrait.next_question(session[remote_ip]['question_list'])

  end

  def diagnosis_start
    logger.info('[未使用関数が動いた]診断しまーす')
    # TODO: ランダムな質問にする　でX 門答えたら回答を出すようにする。
    remote_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
    session[remote_ip] = {}
    session[remote_ip]['question_list'] = []

    @adult_children_trait = AdultChildrenTrait.next_question(session[remote_ip]['question_list'])
    render 'diagnosis', layout: false # レイアウトをなしにする場合
  end

  def diagnosis
    # これはconcern できりだしてもいいかも
    logger.debug('次の質問')

    # TODO: ランダムな質問にする　でX 門答えたら回答を出すようにする。
    remote_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
    if session[remote_ip].nil?
      ＃無視　→おかしい TODO エラー処理
    else

      # 質問に対する答えがYESだったらセッションに保持する
      session[remote_ip]['question_yes_ids'] = [] if session[remote_ip]['question_yes_ids'].nil?

      if params[:yes_no].to_i == 1
        logger.debug('yeボタンがおされました')
        session[remote_ip]['question_yes_ids'].push(params[:id].to_i)
      end

      session[remote_ip]['question_list'].push(params[:id].to_i)

      # 終了判断による分岐
      if AdultChildrenTrait.is_finish_diagnosis(session[remote_ip]['question_list'], session[remote_ip]['question_yes_ids']) == false        # 次の質問
        @adult_children_trait = AdultChildrenTrait.next_question(session[remote_ip]['question_list'])

        logger.debug('質問実行数：' + session[remote_ip]['question_list'].size.to_s)
        # TODO: 診断がおわったらセッションを消す
        render 'diagnosis', layout: false # レイアウトをなしにする場合
      else
        # 診断終了→結果を表示する
        if AdultChildrenTrait.is_positive(session[remote_ip]['question_yes_ids']) == true
          render 'diagnosis_positive', layout: false # レイアウトをなしにする場合
        else
          render 'diagnosis_negative', layout: false # レイアウトをなしにする場合
        end
      end
    end
  end
end
