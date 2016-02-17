require_relative '../test_helper'

module Services
  class ImportFileTest < ActiveSupport::TestCase
    context 'import file sevice tests' do
      setup do
        import_files = %w{ imports/test_transactions1.csv imports/test_not_csv.txt }
        import_files.each{ |file| File.delete(file) if File.exist?(file) }

        @file                = create_attachment_file 'test_transactions1.csv'
        @non_csv_file        = create_attachment_file 'test_not_csv.txt'
        @format_problem_file = create_attachment_file 'test_format_problem.csv'
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

      should 'not copy the file if it is not a csv file' do
        Services::ImportFile.new.call(@non_csv_file)
        assert !File.exist?('imports/test_not_csv.txt')
      end

      should 'create an import record if it is not a csv file' do
        Services::ImportFile.new.call(@non_csv_file)
        assert_equal 1, Import.count
        assert Import.first.message.present?, 'There should be an import message'
        assert_equal 'Not a csv file', Import.first.message
      end

      should 'create transactions records from the import file' do
        Services::ImportFile.new.call(@non_csv_file)
        assert_equal 1, Import.count
        assert Import.first.message.present?, 'There should be an import message'
        assert_equal 'Not a csv file', Import.first.message
      end

      should 'raise a message if there are formatting problems with the import file' do

      end
    end

    def create_attachment_file(filename, type: 'text/comma-separated-values')
      ActionDispatch::Http::UploadedFile.new  filename:  filename,
                                              type:      type,
                                              name:      'import_file',
                                              tempfile:  File.open("test/data/#{filename}")

    end
  end
end
