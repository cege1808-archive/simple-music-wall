class Review < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :track

end