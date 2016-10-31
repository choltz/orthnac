Vue.component('data-dropdown', {
  template: '<div class  = "data-dropdown"'
          + '     @click = "visible = !visible">'
          + '  <div>'
          + '    <span class="data-dropdown-selected">{{defaultText}}</span>'
          + '    <i class = "material-icons">arrow_drop_down</i>'
          + '  </div>'
          + '  <div class  = "data-dropdown-items"'
          + '       v-show = "visible">'
          + '    <div class  = "data-dropdown-item"'
          + '         v-for  ="item in items"'
          + '         @click = "selectItem(item)">'
          + '      {{item}}'
          + '    </div>'
          + '  </div>'
          + '</div>',
  props: {
    defaultText: { default: null },
    id:          { default: null },
    url:         { default: ''   }
  },
  data: function() {
    return {
      items:   [],
      visible: false
    };
  },
  methods: {
    getData: function() {
      $.getJSON(this.url, this.loadData );
    },
    loadData: function(data) {
      this.items = data.items;
    },
    selectItem: function(item) {
      application.$emit('data-dropdown:select-item', {id: this.id, item: item});
    }
  },
  mounted: function () {
    this.$nextTick(this.getData);
  }
});
