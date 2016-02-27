module Services
  class ImportFile
    # Public: Create transactional records from the import file, create a record
    # that the import happened, and keep a copy of the file for future reference
    #
    # file - import file path
    def call(file)
      destination = "imports/#{file.original_filename}"
      IO.copy_stream file.path, destination

      import = Import.create! filename: file.original_filename, filepath: destination

      if file.original_filename =~ /csv$/
        begin
          Services::ImportTransactions.new.call(import)
        rescue StandardError => e
          # Capture all import issues and raise as a message
          message = e.message
          detail  = e.backtrace
        end
      else
        message = 'Not a csv file'
      end

      import.update_attributes message: message, detail: detail if message.present? || detail.present?
    end
  end
end
