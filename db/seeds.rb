paddock = [
  {
    team: "Mercedes",
    drivers: [
      {
        first_name: "Lewis",
        last_name: "HAMILTON",
        ui_name: "HAM",
        number: 44
      },
      {
        first_name: "Valtteri",
        last_name: "BOTTAS",
        ui_name: "BOT",
        number: 77
      }
    ]
  },
  {
    team: "Red Bull",
    drivers: [
      {
        first_name: "Max",
        last_name: "VERSTAPPEN",
        ui_name: "VER",
        number: 33
      },
      {
        first_name: "Sergio",
        last_name: "PEREZ",
        ui_name: "PER",
        number: 11
      }
    ]
  },
  {
    team: "McLaren",
    drivers: [
      {
        first_name: "Lando",
        last_name: "NORRIS",
        ui_name: "NOR",
        number: 4
      },
      {
        first_name: "Daniel",
        last_name: "RICCIARDO",
        ui_name: "RIC",
        number: 3
      }
    ]
  },
  {
    team: "Aston Martin",
    drivers: [
      {
        first_name: "Sebastian",
        last_name: "VETTEL",
        ui_name: "VET",
        number: 5
      },
      {
        first_name: "Lance",
        last_name: "STROLL",
        ui_name: "STR",
        number: 18
      }
    ]
  },
  {
    team: "Ferrari",
    drivers: [
      {
        first_name: "Charles",
        last_name: "LECLERC",
        ui_name: "LEC",
        number: 16
      },
      {
        first_name: "Carlos",
        last_name: "SAINZ",
        ui_name: "SAI",
        number: 55
      }
    ]
  },
  {
    team: "Alpine",
    drivers: [
      {
        first_name: "Fernando",
        last_name: "ALONSO",
        ui_name: "ALO",
        number: 14
      },
      {
        first_name: "Esteban",
        last_name: "OCON",
        ui_name: "OCO",
        number: 31
      }
    ]
  },
  {
    team: "Alpha Tauri",
    drivers: [
      {
        first_name: "Pierre",
        last_name: "GASLY",
        ui_name: "GAS",
        number: 10
      },
      {
        first_name: "Yuki",
        last_name: "TSUNODA",
        ui_name: "TSU",
        number: 22
      }
    ]
  },
  {
    team: "Alfa Romeo",
    drivers: [
      {
        first_name: "Kimi",
        last_name: "RAIKKONEN",
        ui_name: "RAI",
        number: 7
      },
      {
        first_name: "Antonio",
        last_name: "GIOVINAZZI",
        ui_name: "GIO",
        number: 99
      }
    ]
  },
  {
    team: "Williams",
    drivers: [
      {
        first_name: "George",
        last_name: "RUSSELL",
        ui_name: "RUS",
        number: 63
      },
      {
        first_name: "Nicholas",
        last_name: "LATIFI",
        ui_name: "LAT",
        number: 6
      }
    ]
  },
  {
    team: "Haas",
    drivers: [
      {
        first_name: "Mick",
        last_name: "SCHUMACHER",
        ui_name: "MSC",
        number: 47
      },
      {
        first_name: "Nikita",
        last_name: "MAZEPIN",
        ui_name: "MAZ",
        number: 9
      }
    ]
  },
]

paddock.each do |team|
  t = Team.create(name: team[:team])
  team[:drivers].each do |driver|
    Driver.create(driver.merge({ team_id: t.id }))
  end
end
