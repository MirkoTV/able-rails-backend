class DriversController < ApplicationController
  def index
    @session = Session.current
    @drivers = Driver.includes(performances: { laps: :sectors })
                     .all
                     .sort_by{ |driver| driver.current_performance.has_valid_times? }
  end
end
