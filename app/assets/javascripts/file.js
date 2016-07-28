var app  = app || {};

// Public: client-side code for the imports page
app.File = function() {
  var fileInput  = $('.file-input');
  var fileButton = $('.file-upload-button');

  // When the import file selection is made, immediately sumbit the form
  fileInput.change(function(e) {
    fileInput.closest('form').submit();
  });

  fileButton.click(function(e) {
    fileInput.click();
  });
};
