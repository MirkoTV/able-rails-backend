class SectorHandlerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Update lap time
    # Update lap sector times
    # Update performance best lap time
    # Update performance best sector times
    # Update performance best potential times (consider all sectors regardless of lap)
    # Update performance average lap time
    # Update driver all time best record
  end
end
