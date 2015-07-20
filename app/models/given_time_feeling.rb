class GivenTimeFeeling < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :situation
  has_one :automatic_thought,  :dependent => :destroy

  enum status:  {step_1: 0, step_2: 1, step_3: 2, step_4: 3, finished: 4}

  def update_after_percentage(percentage_s)
    self.after_percentage = percentage_s[self.feeling.id.to_s].to_i
    self.save
  end

  after_create do
    #自動思考を生成する
    logger.debug("自動思考レコードも生成する。#{self.id}")
    self.build_automatic_thought(contents: '').save
  end

  after_save do
    #logger.debug('GivenTimeFeeling after_save')
  end

  after_update  do
    #logger.debug("GivenTimeFeeling after_update")
  end

  #同じ親に属する自分以外の感情
  def others
    self.situation.given_time_feelings.select {|given_time_feeling| given_time_feeling.id != self.id}
    #code
  end
end
