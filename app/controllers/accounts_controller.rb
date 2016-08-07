class AccountsController < ApplicationController
  def select
    account = Account.find_by(code: params[:account])
    session[:account] = OpenStruct.new account.attributes
    redirect_to dashboard_account_path(params[:account])
  end
end
