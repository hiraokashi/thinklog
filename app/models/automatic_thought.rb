class AutomaticThought < ActiveRecord::Base
  belongs_to :given_time_feeling
  has_many :distortion_patterns
  has_many :bases
  has_many :rebuttals
  has_many :adaptive_thoughts

  # 認知のゆがみを追加する
  def update_distortion(distortion_patterns_params)
    return if distortion_patterns_params.nil?
    ids = distortion_patterns_params.keys
    logger.debug("distortion_ids => #{ids}")
    distortion_patterns = self.distortion_patterns

    distortion_patterns.each do |distortion_pattern|
      distortion_id = distortion_pattern.cognitive_distortion.id.to_s
      if distortion_patterns_params.key?(distortion_id)
        logger.debug("DBにも、フォームにも存在する→なにもしない => #{distortion_id}")
      else
        logger.debug("DBに存在するがフォームでは存在しない→削除する => #{distortion_id}")
        distortion_pattern.destroy
      end
      ids.delete(distortion_id)
    end

    logger.debug('削除用オブジェクトサイズ: ' + distortion_patterns.size.to_s + ', Situationオブジェクトが保持するサイズ数:' + self.distortion_patterns.size.to_s)
    logger.debug('未処理のゆがみID =>  新規追加扱い' + ids.to_s)
    ids.each do |distortion_id|
      distortion_patterns.build(cognitive_distortion: CognitiveDistortion.find(distortion_id))
      save
    end
  end

  def update_basis_and_rebuttal(params_basis, params_rebuttal)
    logger.debug("update basis aßnd rebuttal")
    self.bases[0].update(contents: params_basis[:contents])
    self.rebuttals[0].update(contents: params_rebuttal[:contents])
  end

  def update_adaptive_thought(params_adaptive_thought)
    logger.debug("update adaptive_thought")
    self.adaptive_thoughts[0].update(contents: params_adaptive_thought[:contents])
  end

  after_create do
    # 根拠、反証、適応的思考を生成する
    logger.debug("根拠　反証、適応的思考を生成する#{id}")
    bases.create(contents: '', automatic_thought: self)
    rebuttals.create(contents: '', automatic_thought: self)
    adaptive_thoughts.create(contents: '', automatic_thought: self)
  end
end
