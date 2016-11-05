// Graph component: use google graph APi to display summary spending information
//
// id - identifing element used by google graph api to place the rendered
//      content in the correct container
Vue.component('graph', {
  template: '<div :id="id"></div>',
  props: {
    id: { default: null }
  },
  data: function() {
    return   {
      // Holds onto the data returned from the server
      graphData: null
    };
  },
  methods: {
    // Initialize the google graph render workflow
    beginRender: function(data) {
      this.graphData = data;

      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(this.drawChart);
    },
    // Set graph render details
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
    // Retrieve graph data from the server
    getGraphData: function(condition, filterId) {
      if (filterId == 'category') {
        queryString = '?category=' + condition;
      }
      else if (filterId == 'date') {
        queryString = '?date=' + condition;
      }
      else {
        queryString = '';
      }

      $.getJSON('api/dashboard/graph' + queryString, this.beginRender );
    },
    updateFilter: function(data) {
      this.getGraphData(data.item, data.id);
    }
  },
  beforeDestroy: function() {
    application.$off('data-dropdown:select-item', this.updateFilter);
  },
  mounted: function () {
    this.$nextTick(function() {
      this.getGraphData();
      application.$on('data-dropdown:select-item', this.updateFilter);
    });
  }
});
