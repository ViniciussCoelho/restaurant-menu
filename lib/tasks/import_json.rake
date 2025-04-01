require Rails.root.join('app/services/use_cases/import_json_data')

namespace :json do
  desc "Import JSON data into the database"
  task import: :environment do
    file_path = ENV['FILE']

    if file_path.blank?
      puts "Please provide a JSON file path with FILE=path/to/file.json"
      exit
    end

    unless File.exist?(file_path)
      puts "File not found: #{file_path}"
      exit
    end

    file = Struct.new(:original_filename, :read).new(File.basename(file_path), File.read(file_path))

    begin
      result = UseCases::ImportJsonData.new(file).execute
      puts "Import finished. Message: #{result[:message]}, results: #{result[:results]}"
    rescue StandardError => e
      puts "Error importing JSON: #{e.message}"
    end
  end
end
