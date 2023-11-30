class UserMailer < ApplicationMailer
  def confirmation_instructions(user)
    @resource = user
    mail(to: user.email, subject: 'Confirmation Instructions')
  end
end
