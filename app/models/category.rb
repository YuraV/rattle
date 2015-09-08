class Category < ActiveRecord::Base
  attr_accessible :published, :title, :description

  has_many :posts
  belongs_to :user

  has_reputation :votes, source: :user, aggregated_by: :sum

  scope :popular, -> { reorder('votes desc').find_with_reputation(:votes, :all) }

end
