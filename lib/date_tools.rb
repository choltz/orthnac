class DateTools
  class << self
    # Public: Return a map enumerator over the date range given, starting on
    # the day specified
    #
    # stat_date - beginning of he date range
    # end_date  - end of the date range
    # day       - day of month to return in each iteration
    #
    # Returns: enumerator
    def map_month(start_date, end_date, day: 1, &block)
      (start_date..end_date).select{ |date| date.day == day }
                            .map(&block)
    end

    def month_and_day(date)
      date.month.to_s.rjust(2, '0') + date.day.to_s.rjust(2,'0')
    end
  end
end
