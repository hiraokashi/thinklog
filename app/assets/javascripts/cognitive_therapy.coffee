# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    $('input[type="range"]').rangeslider();
    $(".feeling_selecter").click ->

      feeling_id = $(this).attr('id').replace('feeling_id_', '')
      situation_id = $("input[name~='situation_id']").val()
      button = $(this)
      $.ajax
        url: '/cognitive_therapy/add_feeling/' + situation_id + '/'+ feeling_id
        type:'GET'
        dataType: 'html'
        timeout:10000
        success: (data) ->
          $(data).prependTo("#feeling_select")
          button.addClass('disabled')

          #自動思考のビューを更新する。
          $.ajax
            url: '/cognitive_therapy/add_automatic_thought/' + $(data).find('input[name="given_time_feeling_id"]').val()
            dataType: 'html'
            timeout:10000
            success: (data) ->
              #成功時の処理
              $(data).prependTo("#automatic_thought_select")
            error: (data) ->
              alert("感情の選択に失敗しました")
        error: (data) ->
          alert("感情の選択に失敗しました")
