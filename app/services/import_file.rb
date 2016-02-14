module Services
  class ImportFile
    # Public: Create transactional records from the import file, create a record
    # that the import happened, and keep a copy of the file for future reference
    #
    # file - import file path
    def call(file)
      destination = "imports/#{file.original_filename}"

      IO.copy_stream file.path, destination if file.original_filename =~ /csv$/
      Import.create! filename: file.original_filename, filepath: destination
    end
  end
end
