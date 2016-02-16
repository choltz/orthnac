require 'csv'

module Services
  class ImportTransactions
    include Services::Base

    # Public: Given an import file path, import the contents into the
    # transactions table
    #
    # file - path of the file to import
    def call(file = nil)
      validate_presence_of file

      CSV.foreach(file, headers: true) do |row|
        next if row['Originating Account Number'].blank?

        # strip leading and trailing space from each value in the row
        row = row.headers
                 .select(&:present?)
                 .inject({}){ |hash, header| hash.merge(header => row[header].strip) }

        Transaction.create! account_number:   row['Originating Account Number'],
                            posted_at:        Date.strptime(row['Posting Date'], '%m/%d/%Y'),
                            transaction_at:   Date.strptime(row['Trans Date'],   '%m/%d/%Y'),
                            category:         row['Category'],
                            merchant_name:    row['Merchant Name'],
                            merchant_city:    row['Merchant City'],
                            merchant_state:   row['Merchant State'],
                            description:      row['Description'],
                            transaction_type: row['Transaction Type'],
                            amount:           row['Amount'].gsub(/\$/, ''),
                            reference:        row['Reference Number']
      end
    end
  end
end
