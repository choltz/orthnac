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
      .between(*Setting.current_statement_dates)
  }

  scope :search, ->(query) {
    like_query = "%#{query}%"
    where("category like ?
           or merchant_name like ?
           or amount = ?", like_query, like_query, query)
  }

  # Class Methods
  class << self
    # Public: Get a list of categories and codes sorted by those containing
    # the highest transactional amount
    def categories(*category_names)
      categories = Transaction.select('category, sum(amount) as sum')
                              .group('category')
                              .order('sum desc')
      if category_names.present?
        categories = categories.where("category in (?)", category_names)
      end

      categories.map{ |t| [t.category, t.category.gsub(/\W+/, '_').downcase] }
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
    def sums_by_month(*category_names)
      end_date   = Setting.next_statement_billing_date
      start_date = end_date - 1.year
      case_when  = sql_billing_cycle_case(start_date, end_date)

      # Select sum for all transactions per billing month
      query = select("#{case_when} as month, sum(transactions.amount) as sum")

      # Compute the sum for every category
      categories(*category_names).each.with_index do |(category_name, category), index|
        query = query.select("sum(c#{index}.amount) as #{category}_sum")
        query = query.joins("left join transactions c#{index} on c#{index}.id = transactions.id and c#{index}.category = '#{category_name}'")
      end

      query.between(start_date, end_date)
        .where("transactions.transaction_type <> 'Payment'")
        .group(case_when)
        .order('month desc')
    end

    private

    # Internal: Build a case statement to organize results by statement billing
    # month
    #
    # start_date - start of date range
    # end_date   - end of date rante
    #
    # Example: sql_billing_cycle_case(2.months_ago, Date.today)
    #          => 'case when transactions.transaction_at between '2015-02-23' and '2015-03-23' then '2015-02-23'
    #                   when transactions.transaction_at between '2015-03-23' and '2015-04-23' then '2015-03-23' end
    #
    # Returns: string
    def sql_billing_cycle_case(start_date, end_date)
      case_when = DateTools.map_month(start_date, end_date, day: Setting.statement_start_day) do |date|
        "when transactions.transaction_at between '#{date - 1.month}' and '#{date}' then '#{date - 1.month}'"
      end

      "case #{case_when.join(' ')} end"
    end
  end
end
