# Cars on Rails

We want to build an application that tracks the fastest lap times of every
driver in a race session.

A lap is divided into 3 sectors, which we use to measure the lap time. After
completing a sector succesfully, the driver's sector time will be stored. The
sector times are measured down to the millisecond. This is the information for a
particular sector in a session:

| Position | Driver                | Time   | Sector | Session       |
|----------|-----------------------|--------|--------|---------------|
| 1        | 33 Max VERSTAPPEN     | 18.280 | 1      | 2021-Able-FP3 |
| 2        | 44 Lewis HAMILTON     | 18.354 | 1      | 2021-Able-FP3 |
| 3        | 11 Sergio PEREZ       | 18.466 | 1      | 2021-Able-FP3 |
| 4        | 4 Lando NORRIS        | 18.511 | 1      | 2021-Able-FP3 |
| 5        | 77 Valtteri BOTTAS    | 18.658 | 1      | 2021-Able-FP3 |
| 6        | 16 Charles LECLERC    | 18.671 | 1      | 2021-Able-FP3 |
| 7        | 18 Lance STROLL       | 18.693 | 1      | 2021-Able-FP3 |
| 8        | 55 Carlos SAINZ       | 18.746 | 1      | 2021-Able-FP3 |
| 9        | 22 Yuki TSUNODA       | 18.769 | 1      | 2021-Able-FP3 |
| 10       | 3 Daniel RICCIARDO    | 18.782 | 1      | 2021-Able-FP3 |
| 11       | 5 Sebastian VETTEL    | 18.785 | 1      | 2021-Able-FP3 |
| 12       | 31 Esteban OCON       | 18.791 | 1      | 2021-Able-FP3 |
| 13       | 14 Fernando ALONSO    | 18.874 | 1      | 2021-Able-FP3 |
| 14       | 10 Pierre GASLY       | 18.882 | 1      | 2021-Able-FP3 |
| 15       | 7 Kimi RAIKKONEN      | 18.901 | 1      | 2021-Able-FP3 |
| 16       | 63 George RUSSELL     | 18.903 | 1      | 2021-Able-FP3 |
| 17       | 99 Antonio GIOVINAZZI | 18.945 | 1      | 2021-Able-FP3 |
| 18       | 6 Nicholas LATIFI     | 19.124 | 1      | 2021-Able-FP3 |
| 19       | 47 Mick SCHUMACHER    | 19.257 | 1      | 2021-Able-FP3 |
| 20       | 9 Nikita MAZEPIN      | 0.0    | 1      | 2021-Able-FP3 |

These times get updated when a drivers completes a sector, overriding the
previous best times if necessary. After each complete session, the best times
recorded for a driver should look like this:

| Sector | Driver            | Time   |
|--------|-------------------|--------|
| 1      | 33 Max VERSTAPPEN | 18.280 |
| 2      | 33 Max VERSTAPPEN | 33.026 |
| 3      | 33 Max VERSTAPPEN | 18.685 |

## Challenge details

To start, run `rails db:seed`. Then execute both `sidekiq` and `rails runner
runner.rb` and keep them running, this will create a new session and update
sector times every 5 seconds for all the drivers, imitating the usage of the
application if we exposed endpoints for API clients to use.

You can clear all session and performance data by executing `cleanup.rb`.

All tests in the `spec` folder should pass to complete the exercise. Do not
modify the files in this folder. Run them with `rspec .`

### 1: Current session stats

1) Ensure all the model specs pass.

2) In the `sector_handler_job.rb` file, we have a queue that should update the
session times with the current sector data:

- Update the Lap `s[n]_time`, which should be the value of the current sector,
  the first one should update `s1_time`, the second `s2_time` and the third `s3_time`.
- Update the Lap overall `time`, which should be the aggregated value of its
  respective sectors
- Update the Performance `best_s[n]_time` when a new sector with a lower time is
  registered for that performance.
- Update the Performance `best_lap_time` with the best (lowest) lap time of its
  respective laps.
- Update the Performance `best_potential_time` with the best sector times
  across all of its laps, i.e: you can take sector 1 times from lap 1, sector 2
  times from lap 10 and sector 3 times from lap 15.
- Update the Performance `average_time` with the average of its lap times.
- Update the Driver `all_time_best` time if there's a new best lap.

There's a table displaying the results in the main route. The first three
columns are the most recent sector times, and the PB sector times should be
their personal best times for this session.

| Driver            | Sector 1 | Sector 2 | Sector 3 | Current Lap | Best Lap | PB S1  | PB S2  | PB S3  | PB Lap   | Avg Lap  | All Time Best |
|-------------------|----------|----------|----------|-------------|----------|--------|--------|--------|----------|----------|---------------|
| 33 Max VERSTAPPEN | 18.280   | 33.026   | 18.685   | 1:09.991    | 1:09.987 | 18.271 | 33.021 | 18.685 | 1:09.977 | 1:09.988 | 1:09.977      |
| 44 Lewis HAMILTON | 18.354   | 33.139   | 18.746   | 1:10.239    | 1:10.194 | 18.292 | 33.099 | 18.693 | 1:10.084 | 1:10.112 | 1:10.084      |

3) Update the `views/drivers/index.html.erb` file to display the session information

### 2: Did Not Finish

When we receive a sector time with a `0` value, this means the driver didn't
finish the sector due to an accident.

Update the background job to handle the following actions:

- The current performance for this driver should be marked as DNF
- They should be displayed at the bottom of the table in the main route (use the
  `has_valid_times?` method to check this)
- The potential best sector times and average lap times should not include the
  lap where the DNF occurred in their calculation

| Driver            | Sector 1 | Sector 2 | Sector 3 | Current Lap | Best Lap | PB S1  | PB S2  | PB S3  | PB Lap   | Avg Lap  | All Time Best |
|-------------------|----------|----------|----------|-------------|----------|--------|--------|--------|----------|----------|---------------|
| 33 Max VERSTAPPEN | 18.280   | 33.026   | 18.685   | 1:09.991    | 1:09.987 | 18.271 | 33.021 | 18.685 | 1:09.977 | 1:09.988 | 1:09.977      |
| 44 Lewis HAMILTON | 18.354   | 33.139   | 18.746   | 1:10.239    | 1:10.194 | 18.292 | 33.099 | 18.693 | 1:10.084 | 1:10.112 | 1:10.084      |
| ...               | ...      | ...      | ...      | ...         | ...      | ...    | ...    | ...    | ...      | ...      | ...           |
| 9  Nikita MAZEPIN | 18.938   | DNF      | DNF      | DNF         | 1:14.783 | 19.492 | 34.484 | 20.553 | 1:14.529 | 1:15.103 | 1:14.893      |

### 3: Real time

Use ActionCable to update the results table in real time.




-------------------------------------------------------

# To setup the project/database
1. setup your db credentials and host in case you use a db that is not in localhost (database.yml)
2. rails db:setup
3. rails db:seed
4. raild db:migrate
5. bundle exec webpack:install

# In order to reset the data:
1. Ensure you are not running rails runner runner.rb
2. Ensure you are not running sidekiq
3. run: rails runner cleanup.rb
4. In rails console, clean up redis: Sidekiq.redis(&:flushdb)
