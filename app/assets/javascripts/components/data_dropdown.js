// Graph component: use google graph APi to display summary spending information
//
// id - identifing element used by google graph api to place the rendered
//      content in the correct container
Vue.component('data-dropdown', {
  template: '<div class  = "data-dropdown"'
          + '     @click = "visible = !visible">'
          + '  <div>'
          + '    <span class="data-dropdown-selected">{{defaultText}}</span>'
          + '    <i class = "material-icons">arrow_drop_down</i>'
          + '  </div>'
          + '  <div v-show="visible" v-for="item in items">'
          + '    {{item}}'
          + '  </div>'
          + '</div>',
  props: {
    defaultText: { default: null }
  },
  data: function() {
    return {
      items:   [],
      visible: false
    };
  },
  methods: {
    getData: function() {
      $.getJSON('api/transactions/categories', this.loadData );
    },
    loadData: function(data) {
      this.items = data.items;
    }
  },
  mounted: function () {
    this.$nextTick(this.getData);
  }

});
