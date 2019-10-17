class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true

  def album_list
    albums = Work.where(category = "album")
    albums.vote.order()

  end
end
