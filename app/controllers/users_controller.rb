class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)

    # @works = Work.where(user_id: user_id)

    if @user.nil?
        head :not_found
        return
    end
  end
  
  def new
    @user = User.new
  end

  # def create
  #   @user = User.new(user_params)

  #   if @user.nil? || @user.validate_input
  #     flash.now[:error] = "username: can't be blank"
  #     render new_user_path
  #   end
  #   if @user.save
  #     flash[:success] = "User added successfully"

  #     redirect_to user_path(@user.id)
  #   else
  #     flash.now[:error] = "You didn't do it right."
  #     render new_user_path
  #   end
  # end

  # def edit
  #   user_id = params[:id].to_i
  #   @user = User.find_by(id: user_id)

  #   if @user == nil
  #     redirect_to user_path
  #   end
  # end

  # def update
  #   @user = User.find_by(id: params[:id])

  #   unless @driver
  #     head :not_found
  #     return
  #   end

  #   if @user.save
  #     redirect_to user_path(@user.id)
  #   else
  #     redirect_to user_path(@user)
  #   end
  # end

  private

  def user_params
      return params.require(:user).permit(:username, :vote_num, :joined_date)
  end
end
