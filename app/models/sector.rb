class Sector < ApplicationRecord
  belongs_to :lap
  belongs_to :driver

  after_save :queue_sector

  def queue_sector
    SectorHandlerJob.perform_later(self)
  end
end
