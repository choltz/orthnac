class AccountsController < ApplicationController
  def select
    Functions::Accounts.set.call(session, params[:account])
    redirect_to dashboard_account_path(params[:account])
  end
end
