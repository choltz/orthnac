module Services
  # Public: Service that creates transactions from a given import
  class ImportFile
    # Public: Create transactional records from the import file, create a record
    # that the import happened, and keep a copy of the file for future reference
    #
    # file - import file path
    def call(file)
      destination = "imports/#{file.original_filename}"
      IO.copy_stream file.path, destination

      import  = Import.create! filename: file.original_filename,
                               filepath: destination
      results = import_transactions(import)

      import.update_attributes results if results.present?
    end

    private

    # Internal: Import transactions. If there's a problem, capture the message
    # and return it
    #
    # import - import model
    #
    # Returns: hash
    #   message - error message
    #   detail  - error details
    def import_transactions(import)
      return { message: 'Not a csv file' } if import.filepath !~ /csv$/
      Services::ImportTransactions.new.call(import)
    rescue StandardError => e
      # Capture all import issues and return the message
      { message: e.message, detail: e.backtrace }
    else
      {}
    end
  end
end
