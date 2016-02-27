# Public: Transaction model. Contains payments, expenditures, and credits
class Transaction < ActiveRecord::Base
  belongs_to :import

  validates :account_number,   presence:   true
  validates :amount,           presence:   true
  validates :import_id,        presence:   true
  validates :reference,        presence:   true
  validates :reference,        uniqueness: true
  validates :transaction_at,   presence:   true
  validates :transaction_type, presence:   true

  # Return all transactions between the specified start and end date
  scope :between, ->(start_date, end_date) {
    where('transactions.transaction_at between ? and ?', start_date, end_date)
  }

  # Return all transactions, except for payments, since he beginning of the
  # month
  scope :monthly_to_date, -> {
    where("transaction_type <> 'Payment'")
      .between(Date.today.beginning_of_month, Date.today)
  }

  # Class Methods
  class << self
    # Public: Get a list of categories and codes
    def categories
      Transaction.select('distinct(category) as category')
                 .order(:category)
                 .map{ |t| [t.category, t.category.gsub(/\W+/, '_').downcase] }
    end

    # Public: Get an array of category codes
    def category_codes
      categories.map(&:second)
    end

    # Public: Get an array of category codes
    def category_names
      categories.map(&:first)
    end

    # Public: Return the amount of expenditures that have occurred since the
    # first of the month
    #
    # Returns: big decimal
    def monthly_sum_to_date
      monthly_to_date.sum(:amount)
    end

    # Public: Calculate the total spending per month, grouped by month,
    #         include monthly sums by every category
    #
    # Returns: Array of aggregated amounts
    def sums_by_month
      query = select("strftime('%Y-%m', transactions.transaction_at) as month,
                      strftime('%m', transactions.transaction_at) as month_number,
                      sum(transactions.amount) as sum")

      # Compute the sum for every category
      categories.each.with_index do |(category_name, category), index|
        query = query.select("sum(c#{index}.amount) as #{category}_sum")
        query = query.joins("left join transactions c#{index} on c#{index}.id = transactions.id and c#{index}.category = '#{category_name}'")
      end

      query.between(1.year.ago.beginning_of_month, Date.today)
           .where("transactions.transaction_type <> 'Payment'")
           .group("strftime('%Y-%m', transactions.transaction_at)")
           .order('month')
    end
  end
end
