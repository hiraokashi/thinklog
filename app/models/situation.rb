class Situation < ActiveRecord::Base
  belongs_to :user
  enum mood_status:  { positive: 0, neutral: 1, negative: 2 }
  scope :negative, -> { where(mood_status: 2) }
  scope :neutral, -> { where(mood_status: 1) }
  scope :positive, -> { where(mood_status: 0) }
  scope :today, -> { where("occured_time like \'#{Date.today.to_s.gsub(/-/, '')}%\'") }
  has_many :given_time_feelings, ->{order 'created_at DESC' }, dependent: :delete_all



  def self.mood_counts(user)
    [
      where(user_id: user.id).positive.count,\
      where(user_id: user.id).neutral.count,\
      where(user_id: user.id).negative.count\
    ]
  end

  # 気分を1時間単位でカウントして、グラフ用のデータとして返す
  def self.mood_chart_data(situations)
    # 引数は時刻に対して昇順で渡ってくることが前提
    # 最小の時刻を取得
    start_hour = Time.now.hour.to_s if situations.empty?
    start_hour = situations[0].occured_time[9..10] unless situations.empty?

    # 最大の時刻を取得
    #end_hour = situations[situations.size - 1].occured_time[9..10]
    end_hour = Time.now.hour.to_s
    collected = []
    positive_situations = situations.select {|_situation| _situation.positive?}
    neutral_situations = situations.select {|_situation| _situation.neutral?}
    negative_situations = situations.select {|_situation| _situation.negative?}

    positive_count = {}
    neutral_count = {}
    negative_count = {}
    (start_hour..end_hour).each do |_hour|
      positive_count[_hour] = (positive_situations.select{|_situation| _situation.occured_time[9..10] == _hour}).size
      neutral_count[_hour] = (neutral_situations.select{|_situation| _situation.occured_time[9..10] == _hour}).size
      negative_count[_hour] = (negative_situations.select{|_situation| _situation.occured_time[9..10] == _hour}).size
    end
    collected.push(positive_count)
    collected.push(neutral_count)
    collected.push(negative_count)

    #logger.debug(collected)
    collected
  end

  # occured_time_からhhを取り出して数値に変換
  def set_now
      now = Time.now
      self.occured_time = "#{now.year}#{now.month}#{now.day}#{now.hour}#{now.min}#{now.sec}"
  end

  def set_empty(occured_time, user)
    self.where = ''
    self.with_whom = ''
    self.what_have_you_been_doing = ''
    self.occured_time = occured_time
    self.user = user
    # code
  end

  # yyyymmmmddhhMMssを 2015 / 08 / 01 (Sat) 16:42:36 形式にする
  def occured_time_for_view
    # code
    # wNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
    "#{occured_time[0..3]}/ \
    #{occured_time[4..5]}/  \
    #{occured_time[6..7]}   \
    (#{%w(Sun Mon Tue Wed Thu Fri Sat)[occured_time[8, 1].to_i]}) \
    #{occured_time[9..10]}:  \
    #{occured_time[11..12]}: \
    #{occured_time[13..14]}"
  end

  def toSentence
    where + ', ' + with_whom + ', ' + what_have_you_been_doing
  end

  # 今の気持ちを更新する
  def update_feeling_before(feelings_hash)
    if feelings_hash.nil?
      self.given_time_feelings.each do |gtf|
        gtf.destroy
      end
      return
    end
    feeling_ids = feelings_hash.keys

    logger.debug("feeling_ids => #{feeling_ids}")
    given_time_feelings = self.given_time_feelings
    given_time_feelings.each do |given_time_feeling|
      feeling_id = given_time_feeling.feeling.id.to_s
      if feelings_hash.key?(feeling_id)
        # DBにも、フォームにも存在する→データを更新する
        logger.debug("DBにも、フォームにも存在する→データを更新する => #{feeling_id}")
        given_time_feeling.percentage = feelings_hash[feeling_id]
        given_time_feeling.save
      else
        # DBに存在するがフォームでは存在しない→削除する
        logger.debug("DBに存在するがフォームでは存在しない→削除する => #{feeling_id}")
        given_time_feeling.destroy
      end
      feeling_ids.delete(feeling_id) # 処理済みのIDは削除する
    end

    logger.debug('削除用オブジェクトサイズ: ' + given_time_feelings.size.to_s + ', Situationオブジェクトが保持するサイズ数:' + self.given_time_feelings.size.to_s)
    logger.debug('未処理の感情ID =>  新規追加扱い' + feeling_ids.to_s)
    # ここは、DBになくてフォームに存在する→今の気持ちを新規追加する
    feeling_ids.each do |feeling_id|
      given_time_feelings.build(percentage: feelings_hash[feeling_id],  feeling: Feeling.find(feeling_id))
      save
    end

    logger.debug('Situationオブジェクトが保持するサイズ数:' + self.given_time_feelings.size.to_s)
  end
end
