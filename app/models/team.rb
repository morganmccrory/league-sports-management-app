class Team < ActiveRecord::Base
  belongs_to :coach, class_name: "User"
  has_many :playerships
  has_many :players, through: :playerships, source: :user
end
