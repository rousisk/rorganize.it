class PersonMailer < ActionMailer::Base
  default from: "rorganize@do-not-reply.com"

  def new_member_email(group, person)
    @group = group
    @person = person
    @membership = Membership.where(person: @person, group: @group).first

    mail to: @group.email,
         subject: 'Your group has a new member!'
  end

end
