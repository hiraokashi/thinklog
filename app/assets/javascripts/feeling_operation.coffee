$ ->

    #感情を選択する
    $(".feeling_selecter").unbind('click')
    $(".feeling_selecter").click ->
      button = $(this)
      feeling_id   = button.attr('id').replace('feeling_id_', '')
      if button.hasClass('btn-default')
        #ドキュメントから削除する
        $("#selected_feeling" + feeling_id).remove()

        button.removeClass('btn-default')
        button.addClass('btn-primary')

        false
      else

        $.ajax
          url: '/cognitive_therapy/add_feeling/' + feeling_id
          type:'GET'
          dataType: 'html'
          timeout:10000
          success: (data) ->
            $(data).prependTo(button.parent().children().filter('.feeling_select'))
            #button.addClass('disabled')
            button.removeClass('btn-primary')
            button.addClass('btn-default')
            #button.text(button.text() + '(削除)')
          error: (data) ->
            alert("感情の選択に失敗しました")

        false
