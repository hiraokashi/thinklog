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
//= require plugins/Chart
//= require plugins/Chart.StackedBar
//= require_tree .

$(function() {

  // ----------------------------------
  //     気分の構成割合を表すグラフを描画する
  // ----------------------------------
	//////////*Doughnut Chart*///////////
		var doughnutChartData = [
		{
			value: $("#positive_percentage").val(),
			color: "rgba(151,187,205,1)"
		},
		{
			value : $("#neutral_percentage").val(),
			color : "rgba(220,220,220,1)"
		},
		{
			value : $("#negative_percentage").val(),
			color : "rgba(240,73,73,0.8)"
		}
	];

	$('#doughnutChart').waypoint(function() {
		var barChart = new Chart($("#doughnutChart").get(0).getContext("2d")).Doughnut(doughnutChartData);
		$('.animated-legend').addClass('fadeInRight');
	}, { offset: '75%', triggerOnce: true });

  // ----------------------------------
  //     気分の推移を表す折れ線グラフを描画する
  // ----------------------------------
  if ($("#mood_stacked").size() > 0) {
    // 積み上げ棒グラフのサンプル
    //var randomScalingFactor = function(){ return Math.round(Math.random()*100);};
  	//var randomColorFactor = function(){ return Math.round(Math.random()*255);};

  	var barChartData = {
  		labels : $.map($('input.mood_stacked_datalabel'), function(elem){ return $(elem).val();}),
  		datasets : [

  			{
          label : "ポジティブ",
  				fillColor : "rgba(151,187,205,0)",
  				strokeColor : "rgba(151,187,205,0.8)",
  				pointColor : "rgba(151,187,205,1)",
  				pointStrokeColor : "#fff",
  				//highlightFill : "rgba(151,187,205,0.75)",
  				//highlightStroke : "rgba(151,187,205,1)",
  				data : $.map($("input.positive_datapoint"), function(elem){ return $(elem).val();})
  			},
  			{
          label : "ふつう",
  				fillColor : "rgba(220,220,220,0)",
  				strokeColor : "rgba(220,220,220,0.8)",
  				pointColor : "rgba(220,220,220,1)",
  				pointStrokeColor : "#fff",
  				//highlightFill: "rgba(220,220,220,0.75)",
  				//highlightStroke: "rgba(220,220,220,1)",
  				data : $.map($("input.neutral_datapoint"), function(elem){ return $(elem).val();})
  			},
  			{
          label : "ネガティブ",
  				fillColor : "rgba(240,73,73,0)",
  				strokeColor : "rgba(240,73,73,0.8)",
  				pointColor : "rgba(240,73,73,1)",
  				pointStrokeColor : "#fff",
  				//highlightFill : "rgba(240,73,73,0.75)",
  				//highlightStroke : "rgba(240,73,73,1)",
  				data : $.map($("input.negative_datapoint"), function(elem){ return $(elem).val();})
  			}
  		]
  	};
  	$('#mood_stacked').waypoint(function(data) {
  		var ctx = $("#mood_stacked").get(0).getContext("2d");
  		window.moodChart = new Chart(ctx).Line(barChartData, {
  			responsive : true
  		});
    },{
      offset: '75%',
      triggerOnce: true
    });

    for (var i=0; i<barChartData.datasets.length; i++){
      //alert(barChartData.datasets[i].strokeColor);
      var legend_tag = "<span style=\"color:" + barChartData.datasets[i].strokeColor + "\">■</span>&nbsp;";
  		if(barChartData.datasets[i].label){
        legend_tag = legend_tag + barChartData.datasets[i].label + "&nbsp;&nbsp;";
  		}
      //legend_tag = legend_tag + "</li>";
      $('#mood_chart_legend').append(legend_tag);

    }
  }
  /* 判例

  */

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
