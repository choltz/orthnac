module ApplicationHelper
  # Public: Wrapper for consistent file input widget
  #
  # button_text - text to display in the file selection button
  # tag         - text to put in the name and id fields
  #
  # Returns: html safe string containing markup
  def file_input_tag(id: nil)
    <<-HTML.html_safe
      <a class="file-upload-button btn-floating btn-large waves-effect waves-light"><i class="material-icons">add</i></a>
      #{file_field_tag id, class: 'file-input'}
    HTML
  end
end
