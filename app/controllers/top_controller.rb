class TopController < ApplicationController
  def index
    logger.debug('ようこそ！')
    @cognitive_distortions = CognitiveDistortion.all
  end

  def diagnosis_start
    logger.debug('診断しまーす')

    # TODO: ランダムな質問にする　でX 門答えたら回答を出すようにする。
    remote_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
    session[remote_ip] = {}
    session[remote_ip]["question_list"] = []

    logger.debug('nilではありまえん') unless session[remote_ip]["question_list"].nil?

    @adult_children_trait = AdultChildrenTrait.find(1)
    session[remote_ip]["question_list"].push(@adult_children_trait.id)
    render "diagnosis", layout: false # レイアウトをなしにする場合
  end

  def diagnosis
    logger.debug('次の質問')

    # TODO: ランダムな質問にする　でX 門答えたら回答を出すようにする。

    remote_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
    if session[remote_ip].nil?
      ＃無視　→おかしい TODO エラー処理

      # logger.debug(remote_ip + 'はまだありません')
    else
      # logger.debug(remote_ip + 'がまたきたで')

      # 質問に対する答えがYESだったらセッションに保持する
      if params[:yes_no].to_i == 1
        logger.debug('yeボタンがおされました')
        session[remote_ip]["question_yes_ids"] = [] if session[remote_ip]["question_yes_ids"].nil?
        session[remote_ip]["question_yes_ids"].push(params[:id])
      end

      logger.debug('nilです') if session[remote_ip]["question_list"].nil?
      # 次の質問を取得する

      @adult_children_trait = AdultChildrenTrait.next_question(session[remote_ip]["question_list"])
      session[remote_ip]["question_list"].push(params[:id])
      logger.debug("質問実行数：" + session[remote_ip]["question_list"].size.to_s)

    end

    # TODO: 診断がおわったらセッションを消す
    render layout: false # レイアウトをなしにする場合
  end
end
