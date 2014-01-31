class Goal < ActiveRecord::Base
  attr_accessible :title, :description, :private, :owner_id

  validates :title, presence: true
  validates :owner_id, presence: true

  belongs_to(
  :owner,
  class_name: "User",
  foreign_key: :owner_id,
  inverse_of: :goals)
end
