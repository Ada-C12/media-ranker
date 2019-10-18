class WorksController < ApplicationController
  def index
    @all_works_categorized = Work.all_works_categorized
  end

  def top_ten
    @top_ten_categorized = Work.top_ten_categorized
    @spotlight = Work.spotlight
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      return
    end
  end

  def upvote
    @current_user = User.find_by(id: session[:user_id])
    # if user is not logged in
    if @current_user.nil?
      flash[:alert_class] = "warning"
      flash[:warning] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: :back)
      return
    else
      work_id = params[:id]
      @work = Work.find_by(id: work_id)
      @new_vote = @work.upvote(@current_user.id)

      if @new_vote.errors.any?
        flash[:alert_class] = "warning"
        flash[:warning] = "A problem occurred: User has already voted for selected work"
        redirect_back(fallback_location: :back)
        return
      end


      if @work.upvote(@current_user.id)
        flash[:alert_class] = "success"
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: :back)
        return
      else
        flash[:alert_class] = "warning"
        flash[:warning] = "A problem occurred: Please try voting again"
        redirect_back(fallback_location: :back)
        return
      end
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.create(work_params)
    if @work.id?
      redirect_to work_path(@work.id)
    else
      flash.now[:alert_class] = "warning"
      flash.now[:warning] = "errors: #{@work.errors.first}"
      render new_work_path, status: :unprocessable_entity
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    elsif @work.destroy
      redirect_to works_path
      return
    else
      render :index
    end
  end

  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
