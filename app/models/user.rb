class User < ActiveRecord::Base
  attr_reader :provided_password

  has_many :playerships
  has_many :teams, through: :playerships
  has_many :coached_teams, class_name: "Team", foreign_key: :coach_id

  validates :username, :presence => true, :uniqueness => true
  validates :password_hash, :length => { :minimum => 8 }

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @provided_password = pass
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    return user if user && (user.password == password)
    nil
  end
end
