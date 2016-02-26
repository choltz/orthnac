module TransactionHelper
  # Public: Format a decimal value into currency; style it in a div tag
  def format_amount(amount)
    formatted_amount = number_to_currency(amount, negative_format: "(%u%n)")
    css_class        = amount < 0 ? 'negative-amount' : ''
    "<span class=\"#{css_class}\">#{formatted_amount}</span>".html_safe
  end
end
