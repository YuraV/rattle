class Post < ActiveRecord::Base
  attr_accessible :body, :published, :title

  belongs_to :user
  belongs_to :category
  has_many :comments

  has_reputation :votes, source: :user, aggregated_by: :sum

  scope :popular, -> { reorder('votes desc').find_with_reputation(:votes, :all) }
end
