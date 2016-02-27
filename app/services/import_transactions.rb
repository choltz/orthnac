require 'csv'

module Services
  class ImportTransactions
    include Services::Base

    # Public: Given an import file path, import the contents into the
    # transactions table
    #
    # file - path of the file to import
    def call(import)
      raise 'No import model given'                     if import.blank?
      raise "File #{import.filepath} does not exist"    unless File.exist?(import.filepath)
      raise "File #{import.filepath} is not a csv file" if import.filepath !~ /\.csv$/

      CSV.foreach(import.filepath, headers: true) do |row|
        row = trim_data(row)

        next if row['Originating Account Number'].blank?

        if !Transaction.exists?(reference: row['Reference Number'])
          Transaction.create! data(row, import)
        end
      end
    end

    private

    # Internal: Format data to play nice with AR
    #
    # row    - row hash from CSV construct
    # import - import model
    #
    # Returns: hash appropriate for AR update or create
    def data(row, import)
      amount = (row['Type'] == 'Debit' ? '' : '-') +
               row['Amount'].gsub(/[\$\,\(\)]/, '')

      { account_number:   row['Originating Account Number'],
        posted_at:        Date.strptime(row['Posting Date'], '%m/%d/%Y'),
        transaction_at:   Date.strptime(row['Trans Date'],   '%m/%d/%Y'),
        category:         row['Category'],
        merchant_name:    row['Merchant Name'],
        merchant_city:    row['Merchant City'],
        merchant_state:   row['Merchant State'],
        description:      row['Description'],
        transaction_type: row['Transaction Type'],
        amount:           amount,
        reference:        row['Reference Number'],
        import_id:        import.id }
    end

    # Internal: strip leading and trailing space from each value in the row
    #
    # row - row hash from CSV construct
    #
    # Returns: hash of row data with white-space stripped values
    def trim_data(row)
      row.headers
          .select(&:present?)
          .map{ |key, _| [key, row[key].strip] }.to_h
    end
  end
end
