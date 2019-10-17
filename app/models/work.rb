class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  # this method will be used in homepages view and works#index view
  def album_list
    albums = Work.where(category = "album")
    albums.vote.order()

    #iterate through each work to count the vote
  end
end
