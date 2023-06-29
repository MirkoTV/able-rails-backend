class Team < ApplicationRecord
  has_many :drivers

  validates :name, uniqueness: true

  def is_complete?
    nil
  end
end
