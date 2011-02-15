class MovesController < ApplicationController
  def index
    @moves = Move.mine([current_user]).order('date desc').paginate(:per_page => PER_PAGE, :page => params[:page])
  end

  def show
    @move = find_move
  end

  def new
    @move = Move.new
  end

  def create
    @move = Move.new(params[:move].merge(:user_id => current_user))
    if @move.save
      flash[:notice] = "Successfully created move."
      redirect_to acc_moves_url(:acc => params[:move][:account_id])
    else
      render :action => 'new'
    end
  end

  def edit
    @move = find_move
    @account = @move.account
    @amount = hogwartize(@move.amount)
  end

  def update
    @move = find_move
    @move.date = params[:date]
    @move.amount = dehogwartize(params[:amount])
    if @move.save && @move.update_attributes(params[:move])
      flash[:notice] = "Successfully updated move."
      @acc = MoveType.find(params[:move][:move_type_id]).account
      redirect_to acc_moves_url(:acc => @acc)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @move = find_move
    @move.destroy
    flash[:notice] = "Successfully destroyed move."
    redirect_to moves_url
  end
  
  def acc_moves
    if allowed_acc(params[:acc])
      @account = find_account
      if params[:mtp]
        @moves = Move.account_moves([params[:acc]]).acc_moves_by_type([params[:mtp]]).order("date desc").paginate(:per_page => PER_PAGE, :page => params[:page])
      else
        @moves = Move.account_moves([params[:acc]]).order("date desc").paginate(:per_page => PER_PAGE, :page => params[:page])
      end
    else
      notallowed
    end
  end

  def add_move_alfa
    @account = find_account
    @move_types = @account.move_types
  end

  def add_move_beta
    @account = find_account
    @move_type = MoveType.find(params[:move][:move_type_id])
  end

  def add_move_gama
    @move = Move.new
    
    @move.user_id = session[:user_id]
    @move.account_id = params[:acc]
    @move.move_type_id = params[:mt]
    @move.amount = dehogwartize(params[:move][:money])
    @move.date = params[:date]

    if @move.save && @move.update_attributes(params[:move])
      redirect_to acc_moves_url(:acc => params[:acc])
    else
      redirect_to moves_url
    end
  end

  def add_move
    puts "hi"
  end

private

  def find_move(id = params[:id])
    Move.find(id)
  end

  def find_account(id = params[:acc])
    Account.find(id)
  end

end
