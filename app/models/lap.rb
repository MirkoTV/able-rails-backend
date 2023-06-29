class Lap < ApplicationRecord
  belongs_to :driver
  belongs_to :performance

  has_many :sectors
end
