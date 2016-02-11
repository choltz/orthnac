class ImportsController < ApplicationController
  def upload
    IO.copy_stream params[:import_file].path, "tmp/#{params[:import_file].original_filename}"
    redirect_to import_path
  end
end
