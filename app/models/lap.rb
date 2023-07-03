class Lap < ApplicationRecord
  belongs_to :driver
  belongs_to :performance

  has_many :sectors

  scope :valid, -> { where("s1_time IS NOT NULL AND s2_time IS NOT NULL AND s3_time IS NOT NULL")}
end
