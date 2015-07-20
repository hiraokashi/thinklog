module ApplicationHelper
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

  def step_path(given_time_feeling)
    return "/automatic_thoughts/think/#{given_time_feeling.automatic_thought.id}" if given_time_feeling.step_2?
    return "/automatic_thoughts/think_deeply/#{given_time_feeling.automatic_thought.id}" if given_time_feeling.step_3?
    return "/automatic_thoughts/think_adaptively/#{given_time_feeling.automatic_thought.id}" if given_time_feeling.step_4?
    return "#" #ありえない
  end

  def accordion_not_collapsed?(target_id, cur_id)
    return "collapsed" if target_id != cur_id
    return ""
  end

  def accordion_in?(target_id, cur_id)
    return "in" if target_id == cur_id
    return ""
  end

end
