class ImportsController < ApplicationController
  def index
    @imports = Import.all.order('created_at desc')
  end

  def upload
    Services::ImportFile.new.call params[:import_file]
    redirect_to import_path
  end
end
