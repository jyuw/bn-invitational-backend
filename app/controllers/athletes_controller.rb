class AthletesController < ApplicationController
  #Array.include Results

  def index
    sorted_results
    sorted_athletes
  end

  def create
    athlete = Athlete.new(athlete_params)
    if athlete.save
      Result.create(athlete: athlete)
      flash[:success] = 'Athlete successfully created'
       redirect_to root_path
    else
      flash[:error] = athlete.errors.full_messages.first
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @athlete = Athlete.find_by(id: params[:id])
  end

  def edit
    @athlete = Athlete.find_by(id: params[:id])
  end

  def destroy
    athlete = Athlete.find_by(id: params[:id])
    athlete.destroy
    redirect_to root_path
  end

  def update
    @athlete = Athlete.find_by(id: params[:id])
    if @athlete.update(athlete_params)
     flash.now[:success] = 'Athlete successfully edited'
     redirect_to athlete_path(@athlete)
    else
     flash[:error] = error_message(@athlete)
     render 'edit'
    end
  end

  def toggle
    athlete = Athlete.find(params[:id])
    athlete.open_or_close_voting
    redirect_to root_path
  end

  private

  def sorted_results
    results = Result.all
    @sorted_results = results.sort_by { |result| result[:score] }.reverse
    @sorted_results.each { |result| result.valid_score = true if result.number_of_votes > 4 }
    @sorted_results
  end

  def sorted_athletes
    athletes = Athlete.all
    @sorted_athletes = athletes.sort_by { |athlete| athlete[:starttime] }
    @sorted_athletes
  end

  def athlete_params
    params.require(:athlete).permit(:name, :age, :home, :image, :starttime)
  end
end
