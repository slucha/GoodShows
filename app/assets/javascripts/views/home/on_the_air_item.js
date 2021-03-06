GoodShows.Views.OnTheAirViewItem = Backbone.View.extend({
  template: JST['home/on_the_air_item'],
  render: function () {
    var content = this.template({
      show: this.model
    });
  
    this.$el.html(content);
  
    return this;
  },
  className:'col-lg-4 col-md-6 col-sm-12 home-show-box'
});