require_relative '../test_helper'

module Services
  class ImportFileTest < ActiveSupport::TestCase
    context "import file sevice tests" do
      setup do
        File.delete('imports/test_transactions1.csv') if File.exists?('imports/test_transactions1.csv')

        @file = ActionDispatch::Http::UploadedFile.new  filename:  'test_transactions1.csv',
                                                        type:      'text/comma-separated-values',
                                                        name:      'import_file',
                                                        tempfile:  File.open('test/data/test_transactions1.csv')
      end

      should 'copy the file to the imports folder' do
        Services::ImportFile.new.call(@file)
        assert File.exist?('imports/test_transactions1.csv')
      end

      should 'create an import record to track that the import happened' do
        Services::ImportFile.new.call(@file)

        assert_equal 1,                                Import.count
        assert_equal 'test_transactions1.csv',         Import.first.filename
        assert_equal 'imports/test_transactions1.csv', Import.first.filepath
      end

      should 'create transactions records from the import file' do

      end


      should 'raise a message if there is no import file provided' do

      end

      should 'raise a message if there are formatting problems with the import file' do

      end
    end
  end
end
