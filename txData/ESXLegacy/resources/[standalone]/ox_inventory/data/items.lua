do return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			image = 'burger_chicken.png',
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
			label = 'Lick it',
			action = function(slot)
				print('You licked the burger')
			end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['sprunk'] = {
		label = 'Sprunk',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
		client = {
			image = 'card_id.png'
		}
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money'] = {
		label = 'Money',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Fleeca Card',
		stack = false,
		weight = 10,
		client = {
			image = 'card_bank.png'
		}
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	["alive_chicken"] = {
		label = "Living chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},

	["bread"] = {
		label = "Bread",
		weight = 1,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Cloth",
		weight = 1,
		stack = true,
		close = true,
	},

	["copper"] = {
		label = "Copper",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutted_wood"] = {
		label = "Cut wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fabric"] = {
		label = "Fabric",
		weight = 1,
		stack = true,
		close = true,
	},

	["fish"] = {
		label = "Fish",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixkit"] = {
		label = "Repair Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Repair Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Gas Bottle",
		weight = 2,
		stack = true,
		close = true,
	},

	["gold"] = {
		label = "Gold",
		weight = 1,
		stack = true,
		close = true,
	},

	["iron"] = {
		label = "Iron",
		weight = 1,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marijuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["medikit"] = {
		label = "Medikit",
		weight = 2,
		stack = true,
		close = true,
	},

	["packaged_chicken"] = {
		label = "Chicken fillet",
		weight = 1,
		stack = true,
		close = true,
	},

	["packaged_plank"] = {
		label = "Packaged wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol_raffin"] = {
		label = "Processed oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["slaughtered_chicken"] = {
		label = "Slaughtered chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["stone"] = {
		label = "Stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["washed_stone"] = {
		label = "Washed stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["wool"] = {
		label = "Wool",
		weight = 1,
		stack = true,
		close = true,
	},

	['casino_beer'] = {
		label = 'Beer',
		weight = 0,
		close = true,
		consume = 0,
	},

	['casino_burger'] = {
		label = 'Burger',
		weight = 0,
		close = true,
		consume = 0,
	},

	['casino_chips'] = {
		label = 'Chips',
		weight = 0,
		close = true,
		consume = 0,
		stack = true,
	},

	['casino_coffee'] = {
		label = 'Coffee',
		weight = 0,
		close = true,
		consume = 0,
	},

	['casino_coke'] = {
		label = 'Cola',
		weight = 0,
		close = true,
		consume = 0,
	},

	['casino_donut'] = {
		label = 'Chocolate Donut',
		weight = 0,
		close = true,
		consume = 0,
	},

	['casino_ego_chaser'] = {
		label = 'casino ego chaser',
		weight = 0,
		close = true,
		consume = 0,
	},

	['casino_luckypotion'] = {
		label = 'casino luckypotion',
		weight = 0,
		close = true,
		consume = 0,
	},

	['casino_psqs'] = {
		label = 'Casino Ps & Qs',
		weight = 0,
		close = true,
		consume = 0,
	},

	['casino_sandwitch'] = {
		label = 'Sandwitch',
		weight = 0,
		close = true,
		consume = 0,
	},

	['casino_sprite'] = {
		label = 'Sprunk',
		weight = 0,
		close = true,
		consume = 0,
	},

	['boombox'] = {
		label = 'boombox',
		weight = 250,
		close = true,
		consume = 1,
		client = {},
		server = {
			export = 'xradio.boombox',
		}
	},

	["engine_oil"] = {
		label = "Engine Oil",
		weight = 1000,
	  },

	  ["tyre_replacement"] = {
		label = "Tyre Replacement",
		weight = 1000,
	  },

	  ["clutch_replacement"] = {
		label = "Clutch Replacement",
		weight = 1000,
	  },

	  ["air_filter"] = {
		label = "Air Filter",
		weight = 100,
	  },

	  ["spark_plug"] = {
		label = "Spark Plug",
		weight = 1000,
	  },

	  ["brakepad_replacement"] = {
		label = "Brakepad Replacement",
		weight = 1000,
	  },

	  ["suspension_parts"] = {
		label = "Suspension Parts",
		weight = 1000,
	  },

	  -- Engine Items
	  ["i4_engine"] = {
		label = "I4 Engine",
		weight = 1000,
	  },

	  ["v6_engine"] = {
		label = "V6 Engine",
		weight = 1000,
	  },

	  ["v8_engine"] = {
		label = "V8 Engine",
		weight = 1000,
	  },

	  ["v12_engine"] = {
		label = "V12 Engine",
		weight = 1000,
	  },

	  ["turbocharger"] = {
		label = "Turbocharger",
		weight = 1000,
	  },

	  -- Electric Engines
	  ["ev_motor"] = {
		label = "EV Motor",
		weight = 1000,
	  },

	  ["ev_battery"] = {
		label = "EV Battery",
		weight = 1000,
	  },

	  ["ev_coolant"] = {
		label = "EV Coolant",
		weight = 1000,
	  },

	  -- Drivetrain Items
	  ["awd_drivetrain"] = {
		label = "AWD Drivetrain",
		weight = 1000,
	  },

	  ["rwd_drivetrain"] = {
		label = "RWD Drivetrain",
		weight = 1000,
	  },

	  ["fwd_drivetrain"] = {
		label = "FWD Drivetrain",
		weight = 1000,
	  },

	  -- Tuning Items
	  ["slick_tyres"] = {
		label = "Slick Tyres",
		weight = 1000,
	  },
	  
	  ["semi_slick_tyres"] = {
		label = "Semi Slick Tyres",
		weight = 1000,
	  },

	  ["offroad_tyres"] = {
		label = "Offroad Tyres",
		weight = 1000,
	  },

	  ["drift_tuning_kit"] = {
		label = "Drift Tuning Kit",
		weight = 1000,
	  },

	  ["ceramic_brakes"] = {
		label = "Ceramic Brakes",
		weight = 1000,
	  },

	  -- Cosmetic Items
	  ["lighting_controller"] = {
		label = "Lighting Controller",
		weight = 100,
		client = {
		  event = "jg-mechanic:client:show-lighting-controller",
		}
	  },

	  ["stancing_kit"] = {
		label = "Stancer Kit",
		weight = 100,
		client = {
		  event = "jg-mechanic:client:show-stancer-kit",
		}
	  },

	  ["cosmetic_part"] = {
		label = "Cosmetic Parts",
		weight = 100,
	  },

	  ["respray_kit"] = {
		label = "Respray Kit",
		weight = 1000,
	  },

	  ["vehicle_wheels"] = {
		label = "Vehicle Wheels Set",
		weight = 1000,
	  },

	  ["tyre_smoke_kit"] = {
		label = "Tyre Smoke Kit",
		weight = 1000,
	  },

	  ["bulletproof_tyres"] = {
		label = "Bulletproof Tyres",
		weight = 1000,
	  },

	  ["extras_kit"] = {
		label = "Extras Kit",
		weight = 1000,
	  },

	  -- Nitrous & Cleaning Items
	  ["nitrous_bottle"] = {
		label = "Nitrous Bottle",
		weight = 1000,
		client = {
		  event = "jg-mechanic:client:use-nitrous-bottle",
		}
	  },

	  ["empty_nitrous_bottle"] = {
		label = "Empty Nitrous Bottle",
		weight = 1000,
	  },

	  ["nitrous_install_kit"] = {
		label = "Nitrous Install Kit",
		weight = 1000,
	  },

	  ["cleaning_kit"] = {
		label = "Cleaning Kit",
		weight = 1000,
		client = {
		  event = "jg-mechanic:client:clean-vehicle",
		}
	  },

	  ["repair_kit"] = {
		label = "Repair Kit",
		weight = 1000,
		client = {
		  event = "jg-mechanic:client:repair-vehicle",
		}
	  },

	  ["duct_tape"] = {
		label = "Duct Tape",
		weight = 1000,
		client = {
		  event = "jg-mechanic:client:use-duct-tape",
		}
	  },

	  -- Performance Item
	  ["performance_part"] = {
		label = "Performance Parts",
		weight = 1000,
	  },
	  
	  -- Mechanic Tablet Item
	  ["mechanic_tablet"] = {
		label = "Mechanic Tablet",
		weight = 1000,
		client = {
		  event = "jg-mechanic:client:use-tablet",
		}
	  }
} end
