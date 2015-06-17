class GivenTimeFeeling < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :situation
  has_one :automatic_thought

  after_create do
    #自動思考を生成する
    logger.debug("自動思考レコードも生成する。#{self.id}")
    self.build_automatic_thought.save
  end

  after_save do
    #logger.debug('GivenTimeFeeling after_save')
  end

  after_update  do
    #logger.debug("GivenTimeFeeling after_update")
  end
end
