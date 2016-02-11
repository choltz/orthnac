class ImportsController < ApplicationController
  def upload
    Services::ImportFile.new.call params[:import_file]
    redirect_to import_path
  end
end
