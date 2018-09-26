-- for display, 1 = display one at a time, 2 = display all as options, 3 = display one of several options
-- put functions in condition to check if conditions filled

NPCdialogue = {
  [1]= {
  Fennel = {[1] = {
                  text = {"Oh hi "..player.name..".", "The foreman's giving you the evil eye, better get back to work", "We'll talk later ok?"},
                  logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0}}, -- say once
          [2] = {text = {"Not now, I'll talk to you later."},
                logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0}} --repeat
        }, -- repeat
  Mint = {[1] = {text = {"This heat is intense, I think I'm going to pass out.", "I wish I could take a break but the foreman's watching."},
                logic = {next = 3, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0}}, -- say once
          [2] = {text = {"Ok back to work I guess."},
                logic = {next = 2, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0}},-- repeat
          [3] = {text = {"What's your favourite fish?"},
                logic = {next = 4, speaker = "Mint", cond = true, off = false, display = 1}}, -- player response
          [4] = {text = {"Carp", "Trout", "Salmon", "Bass", "Perch"},
                logic = {next = 5, speaker = "player", cond = true, off = false, display = 2}},
          [5] = {text = {"Oh good choice.", "Me too!", "I thought so.", "Cool!", "I see."},
                logic = {next = 2, speaker = "Mint", cond = true, off = false, display = 3, spoken = 0}} -- respond to player options
        },
  Lark = {[1] = {text = {"What are you looking at? Get back to work!"},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0}},
          [2] = {text = {"What do you think you're doing huh?!", "We don't pay you to stand around and chat.", "You're going to make up for this by working overtime tonight."},
                logic = {next = 3, speaker = "Lark", cond = true, off = false, display = 1, spoken = 0}},
          [3] = {text = {"Now GET MOVING! ... *mutters* stupid lazy mudskins..."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0}}
          -- [4] = {text = {"Hah, get ready to lose, loser.", "Too bad."},
          --       logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 3, trigger = {type = "battle", choice = 1}}},
        },
  Finch = {[1] = {text = {"Where do you think you're going?", "The day's not over yet!"},
                logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1}},
           [2] = {text = {"The day's not over yet!"},
                logic = {next = 2, speaker = "Finch", cond = true, off = true, display = 1}}
        }
  }
}


objectText = {
  GardeningSign = "Field Supplies",
  KitchenSign = "Dining Hall",
  DormitorySign = "Dormitory",
  MixingSign = "Potion Mixing"}
