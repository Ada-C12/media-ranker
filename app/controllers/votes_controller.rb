class VotesController < ApplicationController



    def index
        @votes = Vote.all
    end

    def show
    end

    def create
      work_id = params[:work_id].to_i
      @work = Work.find_by(id: work_id)

      user_id = session[:user_id]

      # redirect_to work_path(work_id)

      if user_id.nil?
        flash[:danger] = "user id is nill"
      end
      if work_id.nil?
        flash[:danger] = "work id is nill"
      end

      vote = Vote.where(work_id: work_id, user_id: user_id)
      if vote.length == 0
        vote = Vote.create(
          user_id: user_id,
          work_id: work_id
        )
          flash[:success] = "Successfully upvoted!"
      else
        flash[:warning] = "user: has already voted for this work"
      end

      redirect_to works_path
      
    end

    def update
      

      # create_table "votes", force: :cascade do |t|
      #   t.datetime "created_at", null: false
      #   t.datetime "updated_at", null: false
      #   t.bigint "user_id"
      #   t.bigint "work_id"
      #   t.index ["user_id"], name: "index_votes_on_user_id"
      #   t.index ["work_id"], name: "index_votes_on_work_id"
      # end
    
      


    end

    # def votes_count

    #     @votes = Vote.new()

    #     votes = params[:vote][:vote]
    #     vote = Vote.find_by(vote: vote)

        
    #     if vote
    #       session[:vote_id] = vote.id
    #       flash[:success] = "Successfully voted"
    #     else
    #       new_vote = Vote.create(vote: user)
    #       session[:vote_id] = new_vote.id
    #       flash[:success] = "Successfully logged in as new user #{username}"
    #     end
      
    #     redirect_to root_path
    # end

  
end


