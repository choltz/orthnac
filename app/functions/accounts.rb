module Functions
  class Accounts < FunctionGroup
    compose :find_account_and_set_session, ->(session) { Functions::Models.find_attributes_by >>
                                                         set_session(session) }

    class << self
      # Public: Get the cached account. If it isn't cached, get it from the database.
      # If all else fails, return a default.
      #
      # Returns a function
      #   session: object for state
      #   code:    account code to check
      def get
        Function.new do |session, code|
          hash = session[:account] ||
                 Functions::Models.find_attributes_by(:account, :code).call(code) ||
                 Account.stub_account

          OpenStruct.new hash
        end
      end

      # Public: set the account - save it to session
      #
      # Returns a function
      #   session: object for state
      #   code:    account code to check
      def set
        Function.new do |session, code|
          find_account_and_set_session(session).call(:account, code: code)
        end
      end

      private

      # Internal: Save the given account hash to session scope
      #
      # session - object for state
      #
      # Returns a function
      #   hash - account has to store
      def set_session(session)
        Function.new do |hash|
          session[:account] = hash
        end
      end
    end
  end
end
