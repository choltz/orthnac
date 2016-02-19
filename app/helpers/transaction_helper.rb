module TransactionHelper
  def format_amount(amount)
    if amount < 0
      "<span class=\"negative-amount\">(#{amount.to_s.delete('-')})</span>".html_safe
    else
      amount
    end
  end
end
