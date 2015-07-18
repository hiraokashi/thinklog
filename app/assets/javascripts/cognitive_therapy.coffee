# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    $('input[type="range"]').rangeslider();

    #新規作成モーダルの内容の初期化
    $('#addSituation').click ->
        $("#situationNewModalForm .feeling_select").empty()
        $("#situationNewModalForm div input[type='text']").val('')
        $("#situationNewModalForm a.btn.btn-xs.btn-default").removeClass('btn-default')
        $("#situationNewModalForm a.btn.btn-xs").addClass('btn-primary')

    #編集用フォームをロードする
    $('.edit_situation').click ->
      #複数回実行時のためにいったん空にしておく
      $("#edit_form_pos").empty()
      situation_id   = $(this).attr('id').replace('situation_id_', '')

      $.ajax
        url: '/situations/edit_modal/' + situation_id
        type:'GET'
        dataType: 'html'
        timeout:10000
        success: (data) ->
          alert(data)
          $(data).prependTo("#edit_form_pos")
          $('#situationEditModal').modal('show')
        error: (data) ->
          alert("編集画面のロードに失敗しました")

      false

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
