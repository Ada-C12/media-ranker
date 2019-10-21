class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true
  validates :title, uniqueness: { scope: :category }
  
  def self.top_ten(cat)
    works_by_cat = self.where(category: cat)
    top_ten = works_by_cat.max_by(10) {|work| work.votes.length}
    return top_ten.compact
  end
  
  def self.spotlight
    works = Work.all
    spotlight = works.max_by{|work| work.votes.length}
    return spotlight
    # HYPOTHESIS
    # Scenario A:
    # when a work is younger than the current media spotlight,
    # and that work hits the same number of votes as the current media spotlight,
    # that work will not become the new media spotlight
    # until it exceeds the number of votes.
    # RESULT: true
    # Scenario B:
    # when a work is older than the current media spotlight,
    # and that work hits the same number of votes as the current media spotlight,
    # that work will become the new media spotlight.
    # RESULT: false!!!
    
    # tragically, my hypothesis is false and I now have to rewrite my code to make it work.
    
    # NEW HYPOTHESIS
    # it's alphabetical!
    # when a work ties for most votes with the current media spotlight,
    # whichever work is alphabetically FIRST becomes the new media spotlight.
    # RESULT: also kinda false?
    
    # NEWER HYPOTHESIS
    # it is doing whatever the original is doing
    # and that's fine
  end
  
  
end
