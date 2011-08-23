class Notifier < ActionMailer::Base
  default :from => "from@example.com"
  #default_url_options[:host] = "localhost:3000" #TODO: change this for production or heroku tests
  default_url_options[:host] = "amigoseguidor30.heroku.com"

	def password_reset_instructions(user)
		@user = user
		@url = update_pass_url(@user.perishable_token)
		mail(:to => @user.email, :subject => "Password Reset Instruction")
  end
end
