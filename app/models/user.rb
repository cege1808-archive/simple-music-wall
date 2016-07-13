class User < ActiveRecord::Base

  include BCrypt
  
  # Associations
  has_many :tracks
  has_many :votes
  has_many :reviews

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /.*@.*/ }
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
