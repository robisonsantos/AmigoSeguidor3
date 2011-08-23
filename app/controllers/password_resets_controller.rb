class PasswordResetsController < ApplicationController
#  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      Notifier.deliver_password_reset_instructions(@user)
      redirect_to( :root, :notice => "Instructions to reset your password have been emailed to you" )
    else
      redirect_to( reset_pass_path, :alert =>  "No user was found with email address #{params[:email]}")
    end
  end

  def edit
  end

  def update
    @user.password = params[:password]
    @user.password_confirmation = params[:password]
    if @user.save
      redirect_to(@user, :notice => "Your password was successfully updated")
    else
      render :action => "edit"
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "We're sorry, but we could not locate your account"
      redirect_to root_url
    end
  end
end
