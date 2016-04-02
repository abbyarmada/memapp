Given(/^I have a "(.*?)" Membership$/) do |privilege|
  @member = if privilege == 'Family'
              FactoryGirl.create(:member,
                                 people: [
                                   FactoryGirl.create(:person),
                                   FactoryGirl.create(:person, status: :p, first_name: 'jane')
                                 ],
                                 privilege: FactoryGirl.create(:privilege, name: 'Family'))
            else
              FactoryGirl.create(:member,
                                 people: [FactoryGirl.create(:person)],
                                 privilege: FactoryGirl.create(:privilege, name: privilege))
            end
  @person = @member.people.first
  @partner = @member.people.last
  @member.complete_new_member_process
end
