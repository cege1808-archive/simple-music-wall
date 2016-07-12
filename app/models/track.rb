class Track < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_many :votes

  # Validations
  validates :title, presence: true
  validates :artist, presence: true
  validates :url, format: { with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }


end
