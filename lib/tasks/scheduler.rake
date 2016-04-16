desc "This task is called by the Heroku scheduler add-on"
task :reminder_mail => :environment do
	all_tdls = ToDoList.all
	rmd_tdls = all_tdls.select{|tdl| tdl.todays_todo? && tdl.reminder_mail }
  rmd_usrs = rmd_tdls.map{|rmd_tdl| rmd_tdl.user_id}
  users = rmd_usrs.uniq
  users.each do |user|
  	RemindMailer.remind(user).deliver
  end
end

task :send_reminders => :environment do
  User.send_reminders
end