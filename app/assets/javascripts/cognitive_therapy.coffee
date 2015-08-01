# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

    $('.create_as_empty').click ->

      now = new Date()
      #「年」「月」「日」「曜日」を Date オブジェクトから取り出してそれぞれに代入
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

      occured_time = y + m + d + w + h + min + sec

      $link = $(this)
      button_name = $link.text()
      $.ajax
        url: $link.attr('href') + "/" + occured_time
        type: 'get'
        timeout:10000
        beforeSend: () ->
          $link.attr('disabled', true);
          $link.text('保存中')
        success: () ->
          alert("いやな気分を登録しました。")
        error: () ->
          alert("データの保存に失敗しました")
        complete: () ->
          $link.attr('disabled', false)
          $link.text(button_name)

      false

    #時刻をリアルタイムで表示する
    setInterval ->
      now = new Date()
      #「年」「月」「日」「曜日」を Date オブジェクトから取り出してそれぞれに代入
      y = now.getFullYear()
      m = now.getMonth() + 1
      d = now.getDate()
      w = now.getDay()
      h = now.getHours()
      min = now.getMinutes()
      sec = now.getSeconds()

      # 曜日の表記を文字列の配列で指定
      wNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

      # 「月」と「日」で1桁だったときに頭に 0 をつける
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

      $(".countdown").text(y + ' / ' + m + ' / ' + d + ' (' + wNames[w] + ')'+ ' ' + h + ':' + min + ':' + sec)
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
