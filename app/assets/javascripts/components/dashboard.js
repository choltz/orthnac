Vue.component('graph', {
  template: '<div :id="id">A2 custom component!</div>',
  props: {
    id: { default: null }
  },
  data: {
    graphData: null
  },
  methods: {
    beginRender: function(data) {
      this.graphData = data;

      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(this.drawChart);
    },
    drawChart: function() {
      this.graphData.unshift(['day', 'spent', 'total', 'max', 'projected']);
      this.graphData = google.visualization.arrayToDataTable(this.graphData);

      var options = {
        hAxis: {title: 'day',  titleTextStyle: {color: '#333'}},
        vAxis: {minValue: 0},
        height: 400,
        series: {2:{color:'#cccccc',lineWidth:2},
                 3:{color:'#aaaaaa',lineWidth:2}}
      };

      var chart = new google.visualization.AreaChart(document.getElementById(this.id));
      chart.draw(this.graphData, options);
    },
    getGraphData: function() {
      $.getJSON('api/dashboard/graph', this.beginRender );
    }
  },
  mounted: function () {
    this.$nextTick(this.getGraphData);
  }
});
