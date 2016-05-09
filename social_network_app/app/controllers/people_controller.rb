class PeopleController < ApplicationController
  def index
    @person = Person.new
  end

  def show
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to @person
    else
      render 'index'
    end
  end

private
  def person_params
    params.require(:person).permit(:name, :surname, :password, :mail)
  end
end
