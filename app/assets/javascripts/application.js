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

    var chart_data = {
      labels: ['9月', '10月', '11月'],
      datasets: [
          {
              label: 'りんご',
              fillColor: 'rgba(255, 0, 0, 0.5)',
              strokeColor: 'rgba(255, 0, 0, 0.75)',
              highlightFill: 'rgba(255, 0, 0, 0.75)',
              highlightStroke: 'rgba(255, 0, 0, 1)',
              data: [10, 20, 30]
          },
          {
              label: 'バナナ',
              fillColor: 'rgba(255, 255, 0, 0.5)',
              strokeColor: 'rgba(255, 255, 0, 0.75)',
              highlightFill: 'rgba(255, 255, 0, 0.75)',
              highlightStroke: 'rgba(255, 255, 0, 1)',
              data: [30, 10, 20]
          },
          {
              label: 'みかん',
              fillColor: 'rgba(255, 255, 128, 0.5)',
              strokeColor: 'rgba(255, 255, 128, 0.75)',
              highlightFill: 'rgba(255, 255, 128, 0.75)',
              highlightStroke: 'rgba(255, 255, 128, 1)',
              data: [20, 30, 10]
          }
      ]
  };
  //alert($('#chart_canvas').attr('width'))
  var chart_context = $('#chart_canvas')[0].getContext('2d');

  var chart_option = {};
  //    legendTemplate : "<% for (var i=0; i<datasets.length; i++){%><li><span style=\"color:<%=datasets[i].strokeColor%>\">■</span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%>"
  //};

  var chart = new Chart(chart_context).Bar({
      labels: chart_data.labels,
      datasets: chart_data.datasets
  }, chart_option);

  for (var i=0; i<chart_data.datasets.length; i++){
    //alert(chart_data.datasets[i].strokeColor);
    var legend_tag = "<li><span style=\"color:" + chart_data.datasets[i].strokeColor + "\">■</span>";
		if(chart_data.datasets[i].label){
      legend_tag = legend_tag + chart_data.datasets[i].label;
		}
    legend_tag = legend_tag + "</li>";
    $('#chart_legend').append(legend_tag);

  }

  //$('#chart_legend').html(chart.generateLegend());


  // データ系列 1つの場合の棒グラフ描画処理
  //..データ系列 1つの棒グラフに関しては、slim側で書き方を守れば、jsのコードを書く必要なしになるように実装工夫
  $('.one_data_series_bar_chart').ready(function(){
      //alert("unkoooooo")
      $('.one_data_series_bar_chart').each(function(i,elem){
        var barChartData = {
          labels: $.map($(elem).find("input.datalabel"), function(elem){ return $(elem).val();}),
          datasets: [{
            fillColor: "rgba(255,111,105,0.5)",
            strokeColor: "rgba(255,111,105,1)",
            data: $.map($(elem).find("input.datapoint"), function(elem){ return $(elem).val();})
          }]
        };

        $(elem).find('canvas').waypoint(function(data) {
          var option = {
            scaleOverride : true,
            // Y 軸の値の始まりの値
            scaleSteps : 5,
            scaleStepWidth : 20,
            // Y 軸の値の始まりの値
            scaleStartValue : 0
          };
          var barChart = new Chart($(elem).find('canvas')[0].getContext("2d")).Bar(barChartData, option);
        }, {
          offset: '75%',
          triggerOnce: true
        });
      });
  });



  if ($("#progressBar").size() > 0) {
    var $progressDiv = $("#progressBar");
    var $progressBar = $progressDiv.progressStep({
      activeColor: "#ff6f69",
      visitedFillColor: "gray",
      margin: 30
    });
    $progressBar.addStep("状況");
    $progressBar.addStep("自動思考");
    $progressBar.addStep("根拠・反証");
    $progressBar.addStep("適応的思考");
    $progressBar.addStep("完了！");

    if ($("#step1_situation").size() > 0) {
      $progressBar.setCurrentStep(0);
    } else if ($("#step2_find_automatic_thought").size() > 0) {
      $progressBar.setCurrentStep(1);
      $progressBar.getStep(0).setVisited(true);
    } else if ($("#step3_think_automatic_thought").size() > 0) {
      $progressBar.setCurrentStep(2);
    } else if ($("#step4_think_adaptively").size() > 0) {
      $progressBar.setCurrentStep(3);
    } else if ($("#therapy_finished").size() > 0) {
      $progressBar.setCurrentStep(4);
    } else {
      console.log("ステップがおかしい");
    }
    $progressBar.refreshLayout();
  }

  // progressBarのレスポンシブ処理
  $(window).resize(function() {
    var $progressDiv = $("#progressBar");
    if ($("#progressBar").size() > 0) {
      $progressBar.refreshLayout();
    }

  });
});
