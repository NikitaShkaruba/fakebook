class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to @person
    else
      render 'sht'
    end
  end

private
  def person_params
    params.require(:people).permit(:name, :surname, :password, :gender, :phone_number)
  end
end
