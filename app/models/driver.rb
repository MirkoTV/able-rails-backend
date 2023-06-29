class Driver < ApplicationRecord
  belongs_to :team

  has_many :performances
  has_many :laps
  has_many :sectors

  validates :number, uniqueness: true
  validates :ui_name, uniqueness: true, format: { with: /\A[A-Z]{3}\z/ }

  def current_performance
    performances.last
  end

  def current_lap
    laps.last
  end
end
