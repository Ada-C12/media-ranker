class Vote < ApplicationRecord

    belongs_to :work
    belongs_to :user
    
    # userid and work id
end
