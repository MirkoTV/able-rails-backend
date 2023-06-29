class Performance < ApplicationRecord
  belongs_to :driver
  belongs_to :session

  has_many :laps

  def has_valid_times?
    nil
  end
end
