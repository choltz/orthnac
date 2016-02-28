class SettingsController < ApplicationController
  def edit
    @setting = Setting.first
  end

  def cancel
    flash[:message] = 'The changes have been reverted'
    redirect_to edit_settings_path
  end

  def update
    @setting = Setting.find_by_id(params[:id])

    if @setting.update_attributes(params[:setting].permit(:statement_start_day))
      flash[:message] = 'Settings updated'
      redirect_to edit_settings_path
    else
      flash[:warning] = @setting.errors.full_messages.join('<br/>')
      render :edit
    end
  end
end
