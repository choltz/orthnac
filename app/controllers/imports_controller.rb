class ImportsController < ApplicationController
  def download
    file = File.open(Import.find(1).filepath, 'r')
    send_file file, type: 'application/octet-stream'
  end

  def index
    @imports = Import.all.order('created_at desc')
  end

  def upload
    Services::ImportFile.new.call params[:import_file]
    redirect_to import_path
  end
end
