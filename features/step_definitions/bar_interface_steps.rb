Then(/^I click on Bar Interface$/) do
  visit bar_interface_people_path
  # save_page #save_and_open_page
end

Then(/^I should have a family membership$/) do
  expect(@member.people.count).to eq(2)
end

Then(/^I should have a CSV file/) do
  # require 'csv'
  csv = CSV.parse(page.text)
  expect(csv.first).to eq(['BarBillies', 'MemClass', 'CardNo', 'LastName', 'FirstName', 'MemNumber', 'Salutation', 'HouseNameNo', 'StreetAddr', 'StreetAddr2', 'Town', 'City', 'PostCode', 'County', 'Country', 'RenewedCurrentYear', 'RenewedDate', 'dob', 'occupation', 'HomePhone', 'Mobile', 'Email', 'Social', 'Racing', 'Cruiser', 'Dinghy', 'Junior', 'MembershipId', 'member_type Y', '1', '', 'Doe', 'John', '1', 'John & jane Doe', 'Apt 123', 'Street 1', 'Street 2', 'Town', 'City', 'Postcode', 'County', 'Country', 'Y', '2016-01-02', '2011-01-01', nil, '01-845-1234', '12345', 'john.doe@testmail.com', 'X', 'X', 'X', 'X', 'X', '1', 'm N', '1', '', 'Doe', 'jane', '2', 'jane Doe', 'Apt 123', 'Street 1', 'Street 2', 'Town', 'City', 'Postcode', 'County', 'Country', 'Y', '2016-01-02', '2011-01-01', '', '01-845-1234', '12345', 'john.doe@testmail.com', 'X', 'X', 'X', 'X', 'X', '1', 'p'])
end
