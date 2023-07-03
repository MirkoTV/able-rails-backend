module TimeUtils
  class << self
    def format(time)
      return "DNF" if time.blank? || time == 0.0

      [time / 60000, (time % 60000) / 1000.0].join(':')
    end
  end
end
