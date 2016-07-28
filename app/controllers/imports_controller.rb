class ImportsController < ApplicationController
  def download
    #
    # TODO: This is fragile
    #
    file = File.open(Import.find(params[:id]).filepath, 'r')
    send_file file, type: 'application/octet-stream'
  end

  def index
    @imports = Import.all.order('created_at desc')
  end

  def message
    @import = Import.find_by_id(params[:id])
  end

  def upload
    Services::ImportFile.new.call params[:import_file]
    redirect_to request.env['HTTP_REFERER']
  end
end
