module ApplicationHelper
  # Public: Wrapper for consistent file input widget
  #
  # button_text - text to display in the file selection button
  # tag         - text to put in the name and id fields
  #
  # Returns: html safe string containing markup
  def file_input_tag(button_text: nil, id: nil, name: nil, css_class: nil)
    <<-HTML.html_safe
      <div class="file-field input-field">
        <div class="btn">
          <span>#{button_text}</span>
          #{file_field_tag(name, id: id, class: css_class)}
        </div>
        <div class="file-path-wrapper">
          <input class="file-path validate" type="text">
        </div>
      </div>
    HTML
  end
end
