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
                logic = {next = 2, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0}}, -- say once
          [2] = {text = {"There sure are a lot of berries to pick."},
                logic = {next = 3, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0}},-- repeat
          [3] = {text = {"What's your favourite fish?"},
                logic = {next = 4, speaker = "Mint", cond = true, off = false, display = 1}}, -- player response
          [4] = {text = {"Carp", "Trout", "Salmon", "Bass", "Perch"},
                logic = {next = 10, offset = 4, speaker = "player", cond = true, off = false, display = 2}},
          [5] = {text = {"Oh good choice."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}}, -- respond to player options
          [6] = {text = {"Me too!"},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}},
          [7] = {text = {"I thought so."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}},
          [8] = {text = {"Cool!"},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}},
          [9] = {text = {"I see..."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0}},
          [10] = {text = {"Ok back to work I guess."},
                logic = {next = 10, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0}},
        },
  Lark = {[1] = {text = {"What are you looking at? Get back to \nwork!"},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0}},
          [2] = {text = {"We don't pay you to stand around and chat.", "You're going to make up for this by \nworking overtime tonight.",
                "Now GET MOVING! ... stupid lazy\nmudskins..."},
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
                logic = {next = 1, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0}}
        },
  Agave = {[1] = {text = {"It's nice to see you, but we'll get in \ntrouble if they see us talking.", "Let's chat after dinner ok?"},
                logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0}}
        },
  Tarragon = {[1] = {text = {"Go away."},
                logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0}}
        }
  },
  [1]= {
  Fennel = {[1] = {
                  text = {""},
                  logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0}} -- say once
        }, -- repeat
  Mint = {[1] = {text = {"Oh you got in trouble too huh?", "Guess this means we both missed\nsupper. Too bad.", "If only these berries weren't\npoisonous..."},
                logic = {next = 1, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0}} -- say once
        },
  Lark = {[1] = {text = {"Hope you learned your lesson."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0}}
        },
  Finch = {[1] = {text = {"Boss says if you pick 60 berries you\ncan leave.", "Make sure you drop them in the barrels or it won't count."},
                logic = {next = 2, speaker = "Finch", cond = true, off = true, display = 1}},
           [2] = {text = {"You haven't filled your quota yet."},
                logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1}},
           [3] = {text = {"Ughh finally. What took you so long?"},
                logic = {next = 3, speaker = "Finch", cond = true, off = true, display = 1}},
           [4] = {text = {"Those berries don't belong to you.", "Better drop them in the barrels or\nyou'll be in biiig trouble."},
                logic = {next = 4, speaker = "Finch", cond = true, off = true, display = 1}}
        },
  Cress = {[1] = {text = {"Oh, uh, hi " ..player.name.. ", happy birthday. Sorry they made you work late."},
                logic = {next = 2, speaker = "Cress", cond = true, off = false, display = 1}},
          [2] = {text = {"It's not your fault.", "Lark is the worst."},
                logic = {next = 3, offset = 2, speaker = "player", cond = true, off = false, display = 2}},
          [3] = {text = {"I know, but I still feel bad."},
                logic = {next = 5, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0}},
          [4] = {text = {"Yeah..."},
                logic = {next = 5, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0}},
          [5] = {text = {"Hopefully tomorrow will be better."},
                logic = {next = 4, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0}},
        },
  Agave = {[1] = {text = {"Oh there you are! I was worried they'd\nkeep you all night.", "Don't worry we saved some dinner for\nyou. And Mint too."},
                logic = {next = 2, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, func = charGivesObject, par = {"I got 1 Rat Soup.", "Rat Soup", 1, "platefull"}}},
           [2] = {text = {"You need to eat at least one meal a\nday to keep your strength up!", "Try not to get in trouble too often or\nyou'll go hungry."},
                logic = {next = 2, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0}}
        },
  Tarragon = {[1] = {text = {"Leave me alone, I'm busy."},
                  logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0}}
        }
  }
}


objectText = {
  GardeningSign = {"Field Supplies"},
  KitchenSign = {"Dining Hall"},
  DormitorySign = {"Dormitory"},
  StoreSign = {"The Shiny Coin: Your Friendly Company Store and Tavern"},
  barrelSmBerriesStatic = {"There are " .. objectInventory["barrelSmBerries"] .. " berries in the barrel."},
  barrelLgBerriesStatic = {"There are " .. objectInventory["barrelLgBerries"] .. " berries in the barrel."},
  plantSm = {"The berries have already been harvested from this plant."},
  plantSmBerries = {"Press Z to Harvest Plum Berries", "...", "I'm too tired to work.", "I can't carry any more."},
  plantLg = {"The berries have already been harvested from this plant."},
  plantLgBerries = {"Press Z to Harvest Rose Berries", "...", "I'm too tired to work.", "I can't carry any more."},
  barrelSmBerries = {"Press Z to drop the Plum Berries in the Barrel"},
  barrelLgBerries = {"Press Z to drop the Rose Berries in the Barrel"},
  stool = {"Sit?"}
  }

journalText = {[1]= {"Day 1 - Lark made me stay late today. He's such a jerk."}

}
