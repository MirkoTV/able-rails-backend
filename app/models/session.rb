class Session < ApplicationRecord
  has_many :performances

  validates :name, uniqueness: true

  def self.current
    nil
  end
end
