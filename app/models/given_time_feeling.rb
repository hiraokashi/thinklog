class GivenTimeFeeling < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :situation
  has_one :automatic_thought,  dependent: :destroy

  enum status:  { step_1: 0, step_2: 1, step_3: 2, step_4: 3, finished: 4 }

  # 進捗ステータスを日本語で返す
  def status_jp
    return 'ステップ1' if self.step_1?
    return 'ステップ2' if self.step_2?
    return 'ステップ3' if self.step_3?
    return 'ステップ4' if self.step_4?
    return '完了'     if self.finished?
    # code
  end



  def update_percentage(percentage_s)
    if self.step_1?
      self.step1_percentage = percentage_s[feeling.id.to_s].to_i
      self.step2_percentage = percentage_s[feeling.id.to_s].to_i
      self.step3_percentage = percentage_s[feeling.id.to_s].to_i
      self.step4_percentage = percentage_s[feeling.id.to_s].to_i
    elsif self.step_2?
      self.step2_percentage = percentage_s[feeling.id.to_s].to_i
      self.step3_percentage = percentage_s[feeling.id.to_s].to_i
      self.step4_percentage = percentage_s[feeling.id.to_s].to_i
    elsif self.step_3?
      self.step3_percentage = percentage_s[feeling.id.to_s].to_i
      self.step4_percentage = percentage_s[feeling.id.to_s].to_i
    elsif self.step_4?
      self.step4_percentage = percentage_s[feeling.id.to_s].to_i
    elsif self.finished?
      logger.info('思考記録が終了している。更新は行わない')
    else
      logger.info('想定していないパス')
      # do Nothing
    end

    save
  end

  #進捗する
  def progress_step_2
    return self.update_attribute(:status, "step_2") if self.step_1?
    logger.info("これ以上は進捗しない#{self.status}")
    true

  end

  def progress_step_3
    return self.update_attribute(:status, "step_3") if self.step_2?
    logger.info("これ以上は進捗しない#{self.status}")
    true
  end

  def progress_step_4
    return self.update_attribute(:status, "step_4") if self.step_3?
    logger.info("これ以上は進捗しない#{self.status}")
    true
  end

  def progress_finished
    return self.update_attribute(:status, "finished") if self.step_4?
    logger.info("これ以上は進捗しない#{self.status}")
    true
  end

  def executed_step2?
    #code
    return true if self.step_2? || self.step_3? || self.step_4? || self.finished?
    false
  end

  def executed_step3?
    #code
    return true if self.step_3? || self.step_4? || self.finished?
    false
  end

  def executed_step4?
    #code
    return true if self.step_4? || self.finished?
    false
  end

  after_create do
    # 自動思考を生成する
    logger.debug("自動思考レコードも生成する。#{id}")
    build_automatic_thought(contents: '').save
  end

  after_save do
    # logger.debug('GivenTimeFeeling after_save')
  end

  after_update  do
    # logger.debug("GivenTimeFeeling after_update")
  end

  # 同じ親に属する自分以外の感情
  def others
    situation.given_time_feelings.select { |given_time_feeling| given_time_feeling.id != id }
    # code
  end

  # 実行済みのステップをリストで返却する
  def executed_steps
    return 1 if self.step_1?
    return 2 if self.step_2?
    return 3 if self.step_3?
    return 4 if self.step_4?
    return 4 if self.finished? #実行ステップは4と同じ
    return 1 #ありえない
  end
end
