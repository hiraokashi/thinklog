#coding: UTF-8
class AdultChildrenTrait < ActiveRecord::Base
  def self.next_question(question_list)
    # ランダムに取り出す

    logger.debug("実行済みの質問:" + question_list.to_s)
    candidates = (1..count).to_a
    candidates.delete_if { |x| question_list.include?(x) }
    logger.debug("候補:" + candidates.to_s)
    next_id = candidates.sample
    logger.debug("次の質問:" + next_id.to_s)
    find(next_id)
  end

  def self.is_finish_diagnosis(question_list, question_yes_ids_list)
    # 診断終了条件

    # yesが上限に達した時
    return true if question_yes_ids_list.size == 5

    # 質問の回答がすべておわったとき。
    logger.debug("現在の質問数:" + question_list.count.to_s)
    return true if question_list.size == 20

    false
  end

  def self.is_positive(question_yes_ids_list)
    return true if question_yes_ids_list.size == 5
    false
  end
end
