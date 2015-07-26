# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

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
