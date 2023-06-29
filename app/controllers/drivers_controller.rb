class DriversController < ApplicationController
  def index
    @session = Session.current
    @drivers = Driver.all
  end
end
