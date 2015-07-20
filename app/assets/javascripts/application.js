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
//
//= require libs/jquery-1.11.2.min
//= require jquery_ujs
//= require turbolinks
//= require libs/modernizr.custom
//= require libs/raphael
//= require plugins/progressStep
//= require plugins/jquery.knob
//= require_tree .

$(function() {

  // サマリーの感情変化グラフ
  $('.feeling_before_after_chart').ready(function(){
      //alert("unkoooooo")
      $('.feeling_before_after_chart').each(function(i,elem){
        var barChartData = {
          labels: ["記録前", "記録後"],
          datasets: [{
            fillColor: "rgba(255,111,105,0.5)",
            strokeColor: "rgba(255,111,105,1)",
            data: [parseInt($(elem).find("input[name='before']").val()), parseInt($(elem).find("input[name='after']").val())]
          }]
        }

        //alert($(elem).find("input[name='before']").val())
        $(elem).find('canvas').waypoint(function(data) {
          var option = {
            scaleOverride : true,
            // Y 軸の値の始まりの値
            scaleSteps : 5,
            scaleStepWidth : 20,
            // Y 軸の値の始まりの値
            scaleStartValue : 0
          }
          var barChart = new Chart($(elem).find('canvas')[0].getContext("2d")).Bar(barChartData, option);
        }, {
          offset: '75%',
          triggerOnce: true
        });
      });
  });



  //type="range"要素に対して適応
  //alert('unko')
  if ($("#progressBar").size() > 0) {
    var $progressDiv = $("#progressBar");
    var $progressBar = $progressDiv.progressStep({
      activeColor: "#ff6f69",
      margin: 30
    });
    $progressBar.addStep("状況を記録しよう");
    $progressBar.addStep("自動思考をみつけよう");
    $progressBar.addStep("自動思考をつきつめよう");
    $progressBar.addStep("適応的に考えよう");

    if ($("#step1_situation").size() > 0) {
      $progressBar.setCurrentStep(0);
    } else if ($("#step2_find_automatic_thought").size() > 0) {
      $progressBar.setCurrentStep(1);
    } else if ($("#step3_think_automatic_thought").size() > 0) {
      $progressBar.setCurrentStep(2);
    } else if ($("#step4_think_adaptively").size() > 0) {
      $progressBar.setCurrentStep(3);
    } else {
      console.log("ステップがおかしい")
    }
    $progressBar.refreshLayout();
  }


  $(window).resize(function() {
    //$(window).width()
    //alert($("#progressBar").css("height"))
    var $progressDiv = $("#progressBar");
    //var $progressBar = $progressDiv.progressStep({ activeColor: "#ff6f69" ,margin: 30});
    if ($("#progressBar").size() > 0) {
      $progressBar.refreshLayout();
    }

  });
});
