require 'csv'

module Services
  class ImportTransactions
    # Public: Import a
    def call(file = nil)
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
