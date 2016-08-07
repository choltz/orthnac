class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_account

  # Maintain the state of the currently selected account. First check the
  # session, then find by parameter. If neither of those yield a result, then
  # return a stub account that represents the default behavior
  def current_account
    # Account.current_account(session, params[:account])
    Functions::Accounts.get(session, params[:account]).call
  end
end
