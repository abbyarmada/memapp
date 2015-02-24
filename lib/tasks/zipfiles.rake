desc "Zip files"
task :zipfiles => :environment do
require 'rake/packagetask'

file_path = Rails.root.join("tmp","renewals")
zip_file_name = 'Renewals_For_Printing.zip'
file_name_with_path = "#{file_path}/#{zip_file_name}"

File.delete(file_name_with_path) if File.exist?(file_name_with_path)
  begin
    Zip::Archive.open(file_name_with_path, Zip::CREATE) do |ar|
      #ar.add_dir(file_path.to_s)
      Dir.glob(file_path.join("*")).each do |path|
        if File.directory?(path)
          ar.add_dir(path)
        else
          ar.add_file(path) # add_file(<entry name>, <source path>)
        end
      end
    end
  end
end
