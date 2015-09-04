$ ->
    #まだ保存されていない今の感情を保存してstep2ヘ進む
    $(".unknown_feeling_step2").unbind('click')
    $(".unknown_feeling_step2").click ->
        #input.dialからpercentageを取り出してパラメータの最後に負荷してリンクする
        $feeling_id = $(this).attr('id').replace(/unknown_feeling_step2/g, "")
        location.href = $(this).attr('href') + "/" + $(".feeling-input#selected_feeling" + $feeling_id + " input.dial").val()
        false

    #感情を選択する
    $(".feeling_selecter").unbind('click')
    $(".feeling_selecter").click ->
      button = $(this)
      feeling_id   = button.attr('id').replace('feeling_id_', '')
      #situationId隠しフィールドでもっておく
      if button.hasClass('btn-default')
        #ドキュメントから削除する
        $("#selected_feeling" + feeling_id).remove()
        $("#go_step2_feeling" + feeling_id).remove()

        button.removeClass('btn-default')
        button.addClass('btn-primary')

        #alert(button.text() + "を削除しました。更新を確定するには保存を実行してください。")

        false
      else

        $.ajax
          url: '/cognitive_therapy/add_feeling/' + feeling_id + "/" + $("input[name='situation_id'][type='hidden']").val()
          type:'GET'
          dataType: 'html'
          timeout:10000
          success: (data) ->

            $(data).prependTo(button.parent().children().filter('.feeling_select'))
            #button.addClass('disabled')
            button.removeClass('btn-primary')
            button.addClass('btn-default')
            #button.text(button.text() + '(削除)')alert("step2に進むには保存して下さい")
            #alert($(data).find('h4').text() + "のstep2に進むには保存して下さい")
          error: (data) ->
            alert("感情の選択に失敗しました")

        false
