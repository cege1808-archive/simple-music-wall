class Vote < ActiveRecord::Base

  # Associations
  belongs_to :users
  belongs_to :tracks

  # Validations
  validates :user_id, uniqueness: true
end