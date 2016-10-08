var app   = app || {};
app.Chart = app.Chart || {};

// Public: client-side code for dashboard charts
//
app.Chart.Dashboard = function(data) {
  var _public = {};

  _public.render = function() {
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);
  };

  function drawChart() {
    data.unshift(['day', 'spent', 'total', 'max', 'projected']);
    data = google.visualization.arrayToDataTable(data);

    var options = {
      hAxis: {title: 'day',  titleTextStyle: {color: '#333'}},
      vAxis: {minValue: 0},
      height: 400,
      series: {2:{color:'#cccccc',lineWidth:2},
               3:{color:'#aaaaaa',lineWidth:2}}
    };

    var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
    chart.draw(data, options);
  }

  return _public;
};
