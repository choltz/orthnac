module Services
  class ImportFile
    def call(file)
      IO.copy_stream file.path, "tmp/#{file.original_filename}"
    end
  end
end
