class MoveTypesController < ApplicationController
  def index
    if allowed_acc(params[:acc])
      @move_types = MoveType.account_move_types([params[:acc]])
    else
      notallowed
    end
  end

  def show
    @move_type = MoveType.find(params[:id])
  end

  def new
    @move_type = MoveType.new
  end

  def create
    @move_type = MoveType.new(params[:move_type])
    if @move_type.save
      flash[:notice] = "Successfully created move type."
      redirect_to @move_type
    else
      render :action => 'new'
    end
  end

  def edit
    @move_type = MoveType.find(params[:id])
  end

  def update
    @move_type = MoveType.find(params[:id])
    if @move_type.update_attributes(params[:move_type])
      flash[:notice] = "Successfully updated move type."
      redirect_to move_type_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @move_type = MoveType.find(params[:id])
    @move_type.destroy
    flash[:notice] = "Successfully destroyed move type."
    redirect_to move_types_url
  end

end
