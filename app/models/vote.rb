class Vote < ActiveRecord::Base

  # Associations
  belongs_to :users
  belongs_to :tracks

end