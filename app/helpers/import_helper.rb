# Public: Import file helper methods
module ImportHelper
  # Public: helper to render circular buttons.
  #
  # text  - text to display in the button
  # icon  - materializecss icon to use (assumes no text provided)
  # url   - target location
  # color - color to style link
  #
  # Returns: a hyperlink
  def import_table_circle_link(text: nil, icon: nil, url: nil, color: nil)
    text    = "<i class=\"material-icons\">#{icon}</i>" if icon.present?
    classes = 'file-download-button btn-floating btn waves-effect waves-light'
    link_to text.html_safe, url, class: "#{classes} #{color}"
  end
end
