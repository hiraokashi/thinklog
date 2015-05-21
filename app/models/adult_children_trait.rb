class AdultChildrenTrait < ActiveRecord::Base
  def self.next_question(question_list)
    # とりあえず30問繰り返す
    logger.debug(question_list.size.to_s)
    return find(1)  if question_list.size >= 30
    return find(question_list.size + 1)
  end
end
