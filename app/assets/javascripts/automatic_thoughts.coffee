# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.cognitive_distortion_selecter').click ->
    #alert($("#distortion_selecter").html())
    button = $(this)
    cognitive_distortion_id = button.attr('id').replace('cognitive_distortion_', '')
    if button.hasClass('btn-default')
      $("input[name='distortion_pattern[" + cognitive_distortion_id + "]']").remove()
      button.removeClass('btn-default').addClass('btn-primary')
    else
      $('<input type="hidden" name="distortion_pattern[' + cognitive_distortion_id + ']" value=' + cognitive_distortion_id + '>').prependTo("#distortion_selecter")
      button.removeClass('btn-primary').addClass('btn-default')
    #alert($("#distortion_selecter").html())
    false
