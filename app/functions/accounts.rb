module Functions
  class Accounts < FunctionGroup
    # Public: Get the cached account. If it isn't cached, get it from the database.
    # If all else fails, return a default.
    def self.get(session, code)
      Function.new do
        hash = session[:account] ||
               Functions::Models.find_attributes_by.call(:account, code: code) ||
               Account.stub_account

        OpenStruct.new hash
      end
    end

    def self.set(session, code)
      Function.new do

      end
    end
  end
end
