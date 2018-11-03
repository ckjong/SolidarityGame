-- for display, 1 = display one at a time, 2 = display all as options, 3 = display one of several options
-- put functions in condition to check if conditions filled

NPCdialogue = {
  [0]= {
  Fennel = {[1] = {
                  text = {"Oh hi "..player.name..".", "The foreman's giving you the evil eye, \nbetter get back to work.", "We'll talk later ok?"},
                  logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0}}, -- say once
          [2] = {text = {"Not now, I'll talk to you later."},
                logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0}} --repeat
        }, -- repeat
  Mint = {[1] = {text = {"This heat is intense, I think I'm going \nto pass out.", "I wish I could take a break but the \nforeman's watching."},
                logic = {next = 3, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0}}, -- say once
          [2] = {text = {"Ok back to work I guess."},
                logic = {next = 2, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0}},-- repeat
          [3] = {text = {"What's your favourite fish?"},
                logic = {next = 4, speaker = "Mint", cond = true, off = false, display = 1}}, -- player response
          [4] = {text = {"Carp", "Trout", "Salmon", "Bass", "Perch"},
                logic = {next = 2, offset = 4, speaker = "player", cond = true, off = false, display = 2}},
          [5] = {text = {"Oh good choice."},
                logic = {next = 2, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}}, -- respond to player options
          [6] = {text = {"Me too!"},
                logic = {next = 2, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}},
          [7] = {text = {"I thought so."},
                logic = {next = 2, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}},
          [8] = {text = {"Cool!"},
                logic = {next = 2, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}},
          [9] = {text = {"I see..."},
                logic = {next = 2, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}}
        },
  Lark = {[1] = {text = {"What are you looking at? Get back to \nwork!"},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0}},
          [2] = {text = {"We don't pay you to stand around and chat.", "You're going to make up for this by \nworking overtime tonight.",
                "Now GET MOVING! ... *mutters* stupid lazy mudskins..."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0}}
          -- [4] = {text = {"Hah, get ready to lose, loser.", "Too bad."},
          --       logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 3, trigger = {type = "battle", choice = 1}}},
        },
  Finch = {[1] = {text = {"Where do you think you're going?", "The day's not over yet!"},
                logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1}},
           [2] = {text = {"The day's not over yet!"},
                logic = {next = 2, speaker = "Finch", cond = true, off = true, display = 1}}
        },
  Cress = {[1] = {text = {"Can't talk now, sorry."},
                logic = {next = 1, speaker = "Cress", cond = true, off = true, display = 1}}
        },
  Agave = {[1] = {text = {"It's nice to see you, but we shouldn't \ntalk while the foreman's watching."},
                logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1}}
        }
  },
  [1]= {
  Fennel = {[1] = {
                  text = {""},
                  logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0}} -- say once
        }, -- repeat
  Mint = {[1] = {text = {"Oh you got in trouble too huh?"},
                logic = {next = 1, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0}} -- say once
        },
  Lark = {[1] = {text = {"Hope you learned your lesson."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0}}
        },
  Finch = {[1] = {text = {"Looks like you missed dinner, too bad \nfor you."},
                logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1}}
        },
  Cress = {[1] = {text = {"Happy birthday."},
                logic = {next = 1, speaker = "Cress", cond = true, off = true, display = 1}}
        },
  Agave = {[1] = {text = {"Don't worry I saved some dinner for \nyou."},
                logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1}}
        }
  }
}


objectText = {
  GardeningSign = {"Field Supplies"},
  KitchenSign = {"Dining Hall"},
  DormitorySign = {"Dormitory"},
  StoreSign = {"The Shiny Coin: Your Friendly Company Store and Tavern"},
  plantSm = {"The berries have already been harvested from this plant."},
  plantSmBerries = {"Press Z to Harvest Plum Berries", "..."},
  plantLg = {"The berries have already been harvested from this plant."},
  plantLgBerries = {"Press Z to Harvest Rose Berries", "..."},
  stool = {"Sit?"}}
