var app  = app || {};
app.Page = app.Page || {};

// Public: client-side code for the imports page
app.Page.Settings = function() {
  var submitLink  = $('#settings-page-save');
  var cancelLink  = $('#settings-page-cancel');
  var form        = submitLink.closest('form');

  // Submit the form if the submit links is clicked
  submitLink.click(function(e) {
    form.submit();
  });

  // Cancel the form if the cancel link is clicked
  cancelLink.click(function(e) {
    document.location.href = '/settings/cancel';
  });
};
