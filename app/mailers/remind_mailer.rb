class RemindMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.remind_mailer.remind.subject
  #
  def remind(user)
  	@user = user
  	@to_do_lists = user.to_do_lists
    @todays_to_do_lists = @to_do_lists.select{|tdl| tdl.todays_todo? && tdl.reminder_mail }
    mail(to: user.email, subject: "[#{Date.today}]のリマインド")
  end
end
