# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

    #現在時刻を文字列で返す関数
    occured_time =  ->
      now = new Date()
      y = now.getFullYear()
      m = now.getMonth() + 1
      d = now.getDate()
      w = now.getDay()
      h = now.getHours()
      min = now.getMinutes()
      sec = now.getSeconds()
      if m < 10
        m = '0' + m
      if d < 10
        d = '0' + d
      if h < 10
        h = '0' + h
      if min < 10
        min = '0' + min
      if sec < 10
        sec = '0' + sec
      wNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

      return  [y, m, d, w, wNames[w], h, min, sec]


    $('.mood_button').click ->

      # 前回の記録から5分以上たってなければやめる。
      mood_status = 0 if $(this).hasClass('current_mood_positive') is true
      mood_status = 1 if $(this).hasClass('current_mood_neutral') is true
      mood_status = 2 if $(this).hasClass('current_mood_negative') is true

      #「年」「月」「日」「曜日」を Date オブジェクトから取り出してそれぞれに代入
      arr_occured_time = occured_time()
      str_occured_time =  arr_occured_time[0] +
                          arr_occured_time[1] +
                          arr_occured_time[2] +
                          arr_occured_time[3] +
                          arr_occured_time[5] +
                          arr_occured_time[6] +
                          arr_occured_time[7]

      $mood_name = $(this).children('.mood_name').children('p').text()
      $prev = $(this).parent().children('.current_mood')
      $current =$(this)

      #選択された顔を大きくする
      $prev.removeClass('current_mood').children('.mood_face').children('i').removeClass('fa-5x').addClass('fa-4x')
      $current.addClass('current_mood').children('.mood_face').children('i').removeClass('fa-4x').addClass('fa-5x')

      $mood_buttons = $('.mood_button').unbind('click')
      f = arguments.callee
      $.ajax
        url: "/situations/create_as_empty/" + str_occured_time + "/" + mood_status
        type: 'get'
        timeout:10000
        beforeSend: () ->
        success: (data) ->
          #alert($mood_name + "な気分を登録しました。")

          # グラフの更新
          # negativeの場合、step1へいくためのダイアログを立ち上げる
          $('.situation-unit').html(data)
        error: () ->
          alert("データの保存に失敗しました")
        complete: () ->
          $mood_buttons.bind('click', f)

      false

    #時刻をリアルタイムで表示する
    setInterval ->
      arr_occured_time = occured_time()
      str_occured_time =  arr_occured_time[0] + ' / ' +
                          arr_occured_time[1] + ' / ' +
                          arr_occured_time[2] + ' (' +
                          arr_occured_time[4] + ' ) ' +
                          arr_occured_time[5] + ':' +
                          arr_occured_time[6] + ':' +
                          arr_occured_time[7]
      $(".countdown").text(str_occured_time)
    , 1000

    $('.finish_therapy').click ->
      # 操作対象のフォーム要素を取得

      $link = $(this)
      button_name = $link.text()
      $.ajax
        url: $link.attr('href')
        type: 'get'
        timeout:10000
        beforeSend: () ->
          $link.attr('disabled', true);
          $link.text('保存中')
        success: () ->
          alert("進捗を更新しました！")
        error: () ->
          alert("データの保存に失敗しました")
        complete: () ->
          $link.attr('disabled', false)
          $link.text(button_name)

      false

    #保存する(step2以降)
    $('.save_therapy_data').click ->
      #codes...
      $button = $(this)
      go_next_step = $(this).hasClass('go_next_step')
      next_step = "#"
      next_step = $(this).attr('href') if go_next_step == true


      # 操作対象のフォーム要素を取得
      $form = $('form')
      button_name = $button.text()
      $.ajax
        url: $form.attr('action')
        type: $form.attr('method')
        data: $form.serialize()
        timeout:10000
        beforeSend: () ->
          $button.attr('disabled', true);
          $button.text('保存中')
        success: () ->
          $button.attr('disabled', false)
          $button.text(button_name)
          location.href = next_step if go_next_step == true
          alert("保存しました！") if go_next_step == false
        error: () ->
          alert("データの保存に失敗しました")

      false
