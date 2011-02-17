class PeopleController < ApplicationController
  def index
    @people = Person.obyname.paginate(:per_page => PER_PAGE, :page => params[:page])
  end

  def people_house
    @people = Person.where("house = '#{params[:house]}'").obyname.paginate(:per_page => PER_PAGE, :page => params[:page])
    @house = params[:house]
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      flash[:notice] = "Successfully created person - #{@person.name}."
      redirect_to @person
    else
      render :action => 'new'
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      flash[:notice] = "Successfully updated person."
      redirect_to person_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    flash[:notice] = "Successfully destroyed person."
    redirect_to people_url
  end
end
