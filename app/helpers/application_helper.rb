module ApplicationHelper

  def is_home(home)
    #code
    return "active" if home == true
    ""
  end

  # 複数列対応用に配列を再構築する
  def arranged_by_columns(model_list, col_num)
    # グリッドシステムは12なので
    return [] unless [1, 2, 3, 4, 6, 12].include?(col_num)

    result = model_list.size.divmod(col_num)
    row_num = result[0]
    row_num += 1 if result[1] != 0

    logger.debug("model_list=#{model_list.size}")
    arranged_list = {}
    (1..row_num).each do |row|
      arranged_list[row] = {}
      (1..col_num).each do |col|
        logger.debug("row_num=#{row}, col_num=#{col}")
        id = (col_num) * (row - 1) + (col - 1)
        arranged_list[row][col] = model_list[id] unless model_list[id].nil?
        # logger.debug(model_list[col * (row) + (col - 1)].nil?)
      end
    end

    arranged_list
  end

  def step_path(given_time_feeling, step)

    return "/situations/edit_for_app/#{given_time_feeling.situation.id}" if step == "step_1"
    return "/automatic_thoughts/think/#{given_time_feeling.automatic_thought.id}" if step == "step_2"
    return "/automatic_thoughts/think_deeply/#{given_time_feeling.automatic_thought.id}" if step == "step_3"
    return "/automatic_thoughts/think_adaptively/#{given_time_feeling.automatic_thought.id}" if step == "step_4"
    logger.debug("うっほー")
    return "#" #ありえない
  end

  def current_step_id(step)
    return "step1_situation" if step == "step_1"
    return  "step2_find_automatic_thought" if step == "step_2"
    return  "step3_think_automatic_thought" if step == "step_3"
    return  "step4_think_adaptively" if step == "step_4"
    return "step4_think_adaptively" if step == "finished"
    #logger.debug("うっほー")
    return "" #ありえないパス
  end

  def accordion_not_collapsed?(target_id, cur_id)
    return "collapsed" if target_id != cur_id
    return ""
  end

  def accordion_in?(target_id, cur_id)
    return "in" if target_id == cur_id
    return ""
  end

  def current_mood(situation, status_i)
    return "" if situation.nil?
    return "current_mood" if situation.mood_status == status_i
    return ""
  end

  def mood_face_size(situation, status_name)
    return "fa-4x" if situation.nil?
    return "fa-5x" if situation.mood_status == status_name
    return "fa-4x"
  end

  def style_goto_record_situation_button(situation)
    return "display: none;" if situation.nil?
    return "display: none;" unless situation.negative?
    return "" # ふつうに表示する
    #code
  end

  def link_goto_record_situation_button(situation)
    return "" if situation.nil?
    return "" unless situation.negative?
    return "/situations/start_recent_step1"
    #code
  end

end
