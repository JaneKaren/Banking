class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  before_filter :admin_required, :except => [:change_pass, :change_pass_f, :update]

  def index
    @users = User.all
  end

  def show
    @user = find_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User #{@user.username} created."
      redirect_to users_url
    else
      render :action => 'new'
    end
  end

  def edit
    @user = find_user
  end

  def update
    @user = find_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "User #{@user.username} has been updated."
      redirect_to users_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = find_user
    old_username = @user.username
    @user.ownerships.clear
    @user.destroy
    flash[:notice] = "Successfully destroyed user: #{old_username}."
    redirect_to users_url
  end

  def change_pass_f
#    @title="User - change password"
    @user = current_user
    @user.password=""
    @user.password_confirmation=""
  end

  def change_pass
    @user = current_user
    old_pass = params[:password][:old]
    new_pass = params[:user][:password]
    new_mail = params[:user][:email]
    if User.authenticate(@user.username, old_pass) # jestli si opravuje vlastni heslo
      unless new_mail == @user.email
        flash[:notice] = 'Email changed.'
        @user.update_attribute('email', new_mail)
      end
      unless new_pass == ''
        if new_pass == params['user']['password_confirmation']
          if new_pass.length.between?(4,40)
            @user.change_password(new_pass)
            flash[:notice] = 'Password changed.'
          else
            flash[:error] = 'Password needs 4-40 characters.'
            render :action => 'change_pass_f'
          end
        else
          flash[:error] = 'Passwords not valid.'
          render :action => 'change_pass_f'
        end
      end
      redirect_to :action => 'change_pass_f'
    else
      flash[:error] = 'Wrond old password.'
      render :action => 'change_pass_f'
    end
  end

  def user_account_list
    @users = User.all
  end

private

  def find_user
    User.find(params[:id])
  end

end
