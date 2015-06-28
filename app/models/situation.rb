class Situation < ActiveRecord::Base
  belongs_to :user
  has_many :given_time_feelings

  #今の気持ちを更新する
  def update_feeling_before(feelings_before_hash)
    feeling_ids = feelings_before_hash.keys

    logger.debug("feeling_ids => #{feeling_ids.to_s}")
    given_time_feelings = self.given_time_feelings
    given_time_feelings.each do |given_time_feeling|
      feeling_id = given_time_feeling.feeling.id.to_s
      if feelings_before_hash.has_key?(feeling_id)
        #DBにも、フォームにも存在する→データを更新する
        logger.debug("DBにも、フォームにも存在する→データを更新する => #{feeling_id}")
        given_time_feeling.before_percentage = feelings_before_hash[feeling_id]
        given_time_feeling.after_percentage = feelings_before_hash[feeling_id]
        given_time_feeling.save
      else
        #DBに存在するがフォームでは存在しない→削除する
        logger.debug("DBに存在するがフォームでは存在しない→削除する => #{feeling_id}")
        given_time_feeling.destroy
      end
      feeling_ids.delete(feeling_id) #処理済みのIDは削除する
    end

    logger.debug("削除用オブジェクトサイズ: " + given_time_feelings.size.to_s + ", Situationオブジェクトが保持するサイズ数:" + self.given_time_feelings.size.to_s)
    logger.debug('未処理の感情ID =>  新規追加扱い' + feeling_ids.to_s)
    #ここは、DBになくてフォームに存在する→今の気持ちを新規追加する
    feeling_ids.each do |feeling_id|
      given_time_feelings.build(before_percentage: feelings_before_hash[feeling_id], feeling: Feeling.find(feeling_id))
      self.save
    end

    logger.debug("Situationオブジェクトが保持するサイズ数:" + self.given_time_feelings.size.to_s)
  end
end
