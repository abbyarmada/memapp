desc "Zip files"
task :zipfiles => :environment do
require 'rake/packagetask'
file_path = Rails.root.join("tmp","renewals")
puts file_path
puts "running...zipfiles"
puts "Current dir: #{File.expand_path(".")}"

#   Rake::PackageTask.new("zipfiles", "1.2.3") do |p|
#      p.need_zip = true
#      puts "class:" + p.class.to_s
#     # p.zip_command ='"C:\Program Files\WinZip\WINZIP64.EXE" -a zipfiles'
#      p.package_files.include("tmp/renewals/*.pdf")
#    end

system("rm -rf #{file_path}/Renewals_For_Printing.zip") 
system("zip -qj #{file_path}/Renewals_For_Printing.zip #{file_path}/*.pdf")

end
