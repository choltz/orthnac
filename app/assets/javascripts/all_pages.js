var app  = app      || {};
app.Page = app.Page || {};

// Public: client-side code that runs on all pages
app.Page.AllPages = function() {
  var flashMessage = $('#flash_message');
  var flashWarning = $('#flash_warning');

  function initialize() {
    // Capture flash messages and raise them as materializecss toasts
    if (flashMessage != undefined) {
      Materialize.toast(flashMessage.html(), 3000, 'grey lighten-5 grey-text text-darken-3');
    }
    // Capture flash messages and raise them as materializecss toasts
    if (flashWarning != undefined) {
      Materialize.toast(flashWarning.html(), 3000, 'red darken-3');
    }
  }

  initialize();
};
