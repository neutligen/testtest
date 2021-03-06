# Preview all emails at http://localhost:3000/rails/mailers/remind_mailer
class RemindMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/remind_mailer/remind
  def remind
    user = User.find_by(email: "neutligen@gmail.com").id
    RemindMailer.remind(user)
  end

end
