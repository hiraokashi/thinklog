class GivenTimeFeeling < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :situation
  has_one :automatic_thought,  :dependent => :destroy

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
end
