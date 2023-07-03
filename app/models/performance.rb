class Performance < ApplicationRecord
  belongs_to :driver
  belongs_to :session

  has_many :laps

  def has_valid_times?
    return true if dnf?

    laps.flat_map(&:sectors).all? { |sector| sector.time != 0 }
  end
end
