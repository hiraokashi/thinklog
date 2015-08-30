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

    $(".mood_button").unbind('click')
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
          $('.goto_record_situation').hide() if mood_status is 0
          $('.goto_record_situation').hide() if mood_status is 1
          alert($mood_name + "な気分を登録しました。")

          # グラフの更新
          # negativeの場合、step1へいくためのダイアログを立ち上げる
          $('.situation-unit').html(data)
          $('.goto_record_situation').show().attr('href', "/situations/start_recent_step1") if mood_status is 2

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

    $(".finish_therapy").unbind('click')
    $('.finish_therapy').click ->
      # 操作対象のフォーム要素を取得

      $do_save = true
      $("textarea").each ->
        #console.log($(this).attr('name'))
        if $(this).val().replace(/[\s　]/g, "") is ""
          alert("未入力項目があります。")
          $(this).focus()
          $do_save = false #このコードでreturn $do_save = false が生成され、ループが抜ける

      return false if $do_save is false

      $link = $(this)
      button_name = $link.text()
      $.ajax
        url: $link.attr('href')
        type: 'get'
        timeout:10000
        beforeSend: () ->
          $link.attr('disabled', true);
          #$link.text('保存中')
        success: () ->
          alert("完了しました！おつかれさまでした！。気分は軽くなりましたか？")
        error: () ->
          alert("データの保存に失敗しました")
        complete: () ->
          $link.attr('disabled', false)
          #$link.text(button_name)

      false

    #保存する(step2以降)
    $(".save_therapy_data").unbind('click')
    $('.save_therapy_data').click ->
      #codes...
      $button = $(this)
      go_next_step = $(this).hasClass('go_next_step')
      go_previous_step = $(this).hasClass('go_previous_step')
      go_to_link = go_next_step is true or go_previous_step is true
      next_link = "#"
      next_link = $(this).attr('href') if go_to_link == true

      $do_save = true
      if go_next_step is true
        #入力チェックを行う。
        $("input[type='text']:not(input.dial)").each ->
          #console.log($(this).attr('name'))
          if $(this).val().replace(/[\s　]/g, "") is ""
            alert("未入力項目があります。")
            $(this).focus()
            $do_save = false #このコードでreturn $do_save = false が生成され、ループが抜ける

        return false if $do_save is false

        $("textarea").each ->
          #console.log($(this).attr('name'))
          if $(this).val().replace(/[\s　]/g, "") is ""
            alert("未入力項目があります。")
            $(this).focus()
            $do_save = false #このコードでreturn $do_save = false が生成され、ループが抜ける

        return false if $do_save is false


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
          #$button.text('保存中')
        success: () ->
          $button.attr('disabled', false)
          #$button.text(button_name)
          location.href = next_link if go_to_link is true
          alert("保存しました！") if go_to_link is false

          #保存のみかつステップ１であれば感情を更新する
          if $('.feeling_select').size() > 0
            $situation_id = $('.feeling_select').attr('id').replace(/situation_id_for_feeling_list/g,"")
            console.log($situation_id)
            $('.feeling_select').load("/situations/update_feeling_list/" + $situation_id)


        error: () ->
          alert("データの保存に失敗しました")
          $button.attr('disabled', false)
          #$button.text(button_name)

      false
