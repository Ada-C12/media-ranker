class Work < ApplicationRecord
  has_many :votes

  validates :title, uniqueness: { scope: :category, message: "You can't add a work with the same title!"}


  # this method will be used in homepages view and works#index view


  # 
  def self.album_list

    return Work
      .where(category: "album")
      .left_joins(:votes)
      .group(:id)
      .order('COUNT(votes.id) DESC')

    #iterate through each work to count the vote
  end
end
