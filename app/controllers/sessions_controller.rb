class SessionsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
#      flash[:notice] = "Logged in successfully."
      redirect_to_target_or_default(my_accounts_url)
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to "/"
  end
end
