require 'csv'

module Services
  class ImportTransactions
    include Services::Base

    # Public: Given an import file path, import the contents into the
    # transactions table
    #
    # file - path of the file to import
    def call(file)
      raise 'No file given'                  if file.blank?
      raise "File #{file} does not exist"    unless File.exist?(file)
      raise "File #{file} is not a csv file" if file !~ /\.csv$/

      CSV.foreach(file, headers: true) do |row|
        row = trim_data(row)

        next if row['Originating Account Number'].blank?

        transaction = Transaction.find_by(reference: row['Reference Number'])

        if transaction.present?
          transaction.update! data(row)
        else
          Transaction.create! data(row)
        end

        file
      end
    end

    private

    # Internal: Format data to play nice with AR
    #
    # row - row hash from CSV construct
    #
    # Returns: hash appropriate for AR update or create
    def data(row)
      { account_number:   row['Originating Account Number'],
        posted_at:        Date.strptime(row['Posting Date'], '%m/%d/%Y'),
        transaction_at:   Date.strptime(row['Trans Date'],   '%m/%d/%Y'),
        category:         row['Category'],
        merchant_name:    row['Merchant Name'],
        merchant_city:    row['Merchant City'],
        merchant_state:   row['Merchant State'],
        description:      row['Description'],
        transaction_type: row['Transaction Type'],
        amount:           row['Amount'].delete('$'),
        reference:        row['Reference Number'] }
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
