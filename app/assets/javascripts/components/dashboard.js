Vue.component('graph', {
  template: '<div>A2 custom component!</div>',

  mounted: function () {
    this.$nextTick(function () {
      $.getJSON('api/dashboard/graph', function(data) {

      });
    });
  }
});
