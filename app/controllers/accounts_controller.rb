class AccountsController < ApplicationController
  before_filter :admin_required, :except => [:my_accounts, :cash_flow_stat, :cf_stat]

  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(params[:account])
    @user = User.find(params[:user][:user_id])
    if @account.save
      @user.accounts << @account
      flash[:notice] = "Successfully created account."
      redirect_to @account
    else
      render :action => 'new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    @user = User.find(params[:user][:user_id]) if params[:user][:user_id]
    if @account.update_attributes(params[:account])
      @user.accounts << @account if @user
      flash[:notice] = "Successfully updated account."
      redirect_to account_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.ownerships.clear
    @account.destroy
    flash[:notice] = "Successfully destroyed account."
    redirect_to accounts_url
  end

  def my_accounts
    @my_accounts = useracc
  end

  def cash_flow_stat
    @accounts = useracc
  end

  def cf_stat
    @account = Account.find(params[:cf][:account_id])
    @from = params[:cf_from].to_date
    @to = params[:cf_to].to_date

    @starting = @account.amount_to_date(@from)
    @ending = @account.amount_to_date(@to)
    @profitting = @ending - @starting
    
    @cf = @account.cash_flow(@from, @to)

    @mts = MoveType.find_all_by_account_id(@account, :joins => :moves, :select => "move_types.*, SUM(moves.amount) as suma", :conditions => ["moves.date BETWEEN ? AND ?", @from.to_date, @to.to_date], :group => "move_types.id", :order => "name")
    
  end

private

  def useracc
    current_user.accounts
  end

end
