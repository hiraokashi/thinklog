// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.


$(function(){

      $(".diagnosis_start").click(function(){
        //alert("診断しまーす1")
        $("#diagnosis_load").empty();
        $("#ajax_preloader").removeClass("fadeInRight").show();

        $.ajax({
          url: 'top/diagnosis_start',
          type:'GET',
          dataType: 'html',
          timeout:10000,
          success: function(data) {
                       $("#diagnosis_load").html(data);
                   },
          error: function(data) {
                       alert("診断画面のロードに失敗しました");
                 },
          complete : function(data) {
                      $("#ajax_preloader").hide();
                 }
        });
        return false;
      });

      $(".diagnosis_next_question").click(function(){
        //alert("診断しまーす");
        var id = $('#trait_id').val();

        var no_yes = 0
        if ($(this).hasClass("question_yes")) {
          no_yes = 1
        }
        $("#diagnosis_load").empty();
        $("#ajax_preloader").removeClass("fadeInRight").show();
        $.ajax({
          url: "top/diagnosis/" + id + "/" + no_yes,
          type:'GET',
          dataType: 'html',
          timeout:10000,
          success: function(data) {
                       $("#diagnosis_load").html(data);
                   },
          error: function(data) {
                       alert("診断画面のロードに失敗しました");
                 },
          complete : function(data) {
                      $("#ajax_preloader").hide();
                 }
        });
        return false;
      });

});
