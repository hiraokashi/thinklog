class GivenTimeFeeling < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :situation
  has_one :automatic_thought,  dependent: :destroy
  scope :status_is, ->(status) { where('status = ?', status) }
  scope :feeling_is, ->(feeling_id) { where('feeling_id = ?', feeling_id) }
  enum status:  { step_1: 0, step_2: 1, step_3: 2, step_4: 3, finished: 4 }

  FeelingCount = Struct.new(:contents, :count) # 結果をinjectしたいためstructの配列で保持する

  def self.count_up_feeling(user)
    all_situation_ids = Situation.where(user_id: user.id).negative.select(:id)
    feeling_counts = []

    Feeling.all.each do |_feeling|
      feeling_counts.push(FeelingCount.new(_feeling.contents, where(situation_id: all_situation_ids).feeling_is(_feeling.id).count))
    end
    feeling_counts = feeling_counts.select { |fc| fc.count > 0 }
    feeling_counts = feeling_counts.sort { |_f1, _f2| _f2.count <=> _f1.count }
    result = {}
    if feeling_counts.size > 6
      # 7件以上ある場合雨とその他に まーじする　
      feeling_counts[0, 5].each do |fc|
        result[fc.contents] = fc.count
      end
      others_count = feeling_counts[5..(feeling_counts.length - 1)].inject(0) { |sum, feeling_count| sum + feeling_count.count }
      result['その他'] = others_count
    else
      feeling_counts.each do |fc|
        result[fc.contents] = fc.count
      end
    end
    result
  end

  def self.count_up_status(user)
    all_situation_ids = Situation.where(user_id: user.id).select(:id)
    feeling_status_counts = {}
    statuses.each do |name_s, _value_i|
      feeling_status_counts[conv_status_jp(name_s)] = \
        where(situation_id: all_situation_ids).status_is(_value_i).count
    end
    feeling_status_counts
  end

  def self.conv_status_jp(name)
    return 'ステップ1' if name == 'step_1'
    return 'ステップ2' if name == 'step_2'
    return 'ステップ3' if name == 'step_3'
    return 'ステップ4' if name == 'step_4'
    return '完了'     if name == 'finished'
  end
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
    self.percentage = percentage_s[feeling.id.to_s].to_i
    save
  end

  # 進捗する
  def progress_step_2
    return update_attribute(:status, 'step_2') if self.step_1?
    logger.info("これ以上は進捗しない#{status}")
    true
  end

  def progress_step_3
    return update_attribute(:status, 'step_3') if self.step_2?
    logger.info("これ以上は進捗しない#{status}")
    true
  end

  def progress_step_4
    return update_attribute(:status, 'step_4') if self.step_3?
    logger.info("これ以上は進捗しない#{status}")
    true
  end

  def progress_finished
    return update_attribute(:status, 'finished') if self.step_4?
    logger.info("これ以上は進捗しない#{status}")
    true
  end

  def executed_step2?
    # code
    return true if self.step_2? || self.step_3? || self.step_4? || self.finished?
    false
  end

  def executed_step3?
    # code
    return true if self.step_3? || self.step_4? || self.finished?
    false
  end

  def executed_step4?
    # code
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

  # 実行済できるステップを返却する
  def executable_steps
    return 2 if self.step_1?
    return 2 if self.step_2?
    return 3 if self.step_3?
    return 4 if self.step_4?
    return 4 if self.finished? # 実行ステップは4と同じ
    1 # ありえない
  end
end
