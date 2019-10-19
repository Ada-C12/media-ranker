class VotesController < ApplicationController

  def create
    @work = Work.find_by(params[:id])
    
    # long_date = DateTime.now.to_s
    # date = long_date[0..9]
    binding.pry
    vote = Vote.new(work_id: @work.id, user_id: @current_user.id, date: Time.now)
    vote.save
    # @work.update(active: true) 
    redirect_to vote_path(params[:vote_id])
    return
  # else 
  #   render :new 
  #   return
  end

  def show
    @vote = Vote.find_by(id: params[:id])
    if @vote.nil?
      redirect_to root_path
      return 
    end
  end
    
  def update
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
      redirect_to root_path
    elsif 
      if @trip.rating == nil
        @trip.update(rating: params[:trip][:rating])
        @trip.driver.update(active: false)
        redirect_to passenger_path(@trip.passenger_id)
      else
        @trip.update(rating: params[:trip][:rating], cost: params[:trip][:cost])
        redirect_to trip_path
      end
    else 
      render :edit 
    end
  end
  
  # def destroy
  #   @trip = Trip.find_by(id: params[:id])
    
  #   if @trip.nil?
  #     head :not_found
  #     return
  #   end
    
  #   @trip.destroy
  #   redirect_to root_path
  #   return
  # end

end
