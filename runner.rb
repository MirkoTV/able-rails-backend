if Driver.count.zero?
  throw StandardError.new("No race drivers available, execute this task: bin/rails db:seed")
end

# remove stale data

Session.all.filter { |s| s.performances.empty? }.map(&:destroy)
Performance.all.filter { |p| p.laps.empty? }.map(&:destroy)
Lap.all.filter { |l| l.sectors.empty? }.map(&:destroy)

# End previous sessions

Session.update_all(active_at: nil)

# let's create a session first

session_type = ["FP1", "FP2", "FP3", "Q1", "Q2", "Q3", "R"].sample
identifier = SecureRandom.urlsafe_base64(nil, false)
session_name = "#{Time.now.year}-Able-#{session_type}-#{identifier}"
session = Session.create(name: session_name, active_at: Time.now)

# then we need performances for individual drivers

performances = Driver.all.map do |driver|
  Performance.create(driver: driver, session: session)
end

# lets keep sector times relatively consistent across drivers

sector_times = [
  [*68000..71000],
  [*96000..99000],
  [*72000..74000],
]

loop do
  laps = performances.map do |performance|
    performance.laps.create(driver: performance.driver)
  end

  3.times do |i|
    laps.map do |lap|
      lap.sectors.create(driver: lap.driver, time: sector_times[i].sample)
    end

    sleep 5.seconds
  end

  sleep 10.seconds
end
