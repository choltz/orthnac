module DashboardHelper
  # Public: Convert the given number into its corresponding month name
  #
  # number - integer or number in a string
  #
  # Returns: String
  def month_name(number)
    Date::MONTHNAMES[number.to_i].downcase
  end
end
