class User < ActiveRecord::Base

  # include BCrypt
  
  # Associations
  has_many :tracks

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /.*@.*/ }
  validates :password, presence: true, length: { minimum: 5 }


  def password

  end

end
