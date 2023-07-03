class SectorHandlerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sector = Sector.find(args[0])
    return unless sector

    lap = sector.lap
    performance = lap.performance
    return if performance.dnf?

    if sector.time <= 0
      performance.update(dnf: true)
      return
    end

    # Update lap sector times
    # Update performance best sector times
    if lap.s1_time.blank?
      lap.update(s1_time: sector.time)
      performance.update(best_s1_time: sector.time) if performance.best_s1_time.blank? || performance.best_s1_time > sector.time
    elsif lap.s2_time.blank?
      lap.update(s2_time: sector.time)
      performance.update(best_s2_time: sector.time) if performance.best_s2_time.blank? || performance.best_s2_time > sector.time
    elsif lap.s3_time.blank?
      lap.update(s3_time: sector.time)
      performance.update(best_s3_time: sector.time) if performance.best_s3_time.blank? || performance.best_s3_time > sector.time
    end

    if(lap.s1_time.present? && lap.s2_time.present? && lap.s3_time.present?)
      # Update lap time
      lap_time = [lap.s1_time, lap.s2_time, lap.s3_time].compact.sum
      lap.update(time: lap_time)
      
      # Update performance best lap time
      performance.update(best_lap_time: lap_time) if performance.best_lap_time.blank? || performance.best_lap_time > lap_time

      # Update driver all time best record
      if lap.driver.all_time_best.blank? || lap.driver.all_time_best > lap_time
        lap.driver.update(all_time_best: lap_time)
      end

      # Update performance average lap time
      performance.update(average_time: performance.laps.valid.average(:time))
    end

    # Update performance best potential times (consider all sectors regardless of lap)
    best_sector_1_time = performance.laps.valid.order(:s1_time).pluck(:s1_time).first
    best_sector_2_time = performance.laps.valid.order(:s2_time).pluck(:s2_time).first
    best_sector_3_time = performance.laps.valid.order(:s3_time).pluck(:s3_time).first

    if(best_sector_1_time.present? && best_sector_2_time.present? && best_sector_3_time.present?)
      performance.update(best_potential_time: [best_sector_1_time, best_sector_2_time, best_sector_3_time].compact.sum)
    end
  end
end
