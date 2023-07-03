class Team < ApplicationRecord
  has_many :drivers

  validates :name, uniqueness: true

  def is_complete?
    drivers_count = drivers.size

    if drivers_count <= 0
      raise NoDriversError.new
    elsif drivers_count == 1
      false
    elsif drivers_count == 2
      true
    else
      raise TooManyDriversError.new
    end
  end
end
