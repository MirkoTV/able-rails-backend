class Sector < ApplicationRecord
  belongs_to :lap
  belongs_to :driver

  after_commit :queue_sector

  def queue_sector
    SectorHandlerJob.perform_later(id)
  end
end
