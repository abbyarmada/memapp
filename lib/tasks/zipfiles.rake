require 'rubygems'
require 'zip'
desc 'Zip files'
task zipfiles: :environment do
  require 'rake/packagetask'

  folder = Rails.root.join('tmp', 'renewals')
  zip_file = 'Renewals_For_Printing.zip'
  zipfile_name = "#{folder}/#{zip_file}"

  File.delete(zipfile_name) if File.exist?(zipfile_name)
  begin
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      Dir.glob(folder.join('*')).each do |filename|
        zipfile.add((File.basename filename), filename)
      end
    end
  end
end
