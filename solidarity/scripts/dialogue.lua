-- for display, 1 = display one at a time, 2 = display all as options, 3 = display one of several options
-- put functions in condition to check if conditions filled

NPCdialogue = {
  [0]= {
  Fennel = {[1] = {
                  text = {"Oh hi "..player.name..".", "The foreman's giving you the evil eye, \nbetter get back to work.", "We'll talk later ok?"},
                  logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1}}, -- say once
          [2] = {text = {"Not now, I'll talk to you later."},
                logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1}} --repeat
        }, -- repeat
  Mint = {[1] = {text = {"This heat is intense, I think I'm going \nto pass out.", "I wish I could take a break but the \nforeman's watching."},
                logic = {next = 2, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}}, -- say once
          [2] = {text = {"There sure are a lot of berries to pick."},
                logic = {next = 3, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}},-- repeat
          [3] = {text = {"What's your favourite fish?"},
                logic = {next = 4, speaker = "Mint", cond = true, off = false, display = 1}}, -- player response
          [4] = {text = {"Carp", "Trout", "Salmon", "Bass", "Perch"},
                logic = {next = 10, offset = 4, speaker = "player", cond = true, off = false, display = 2}},
          [5] = {text = {"Oh good choice."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1}}, -- respond to player options
          [6] = {text = {"Me too!"},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1}},
          [7] = {text = {"I thought so."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1}},
          [8] = {text = {"Cool!"},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1}},
          [9] = {text = {"I see..."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1}},
          [10] = {text = {"Ok back to work I guess."},
                logic = {next = 10, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
        },
  Lark = {[1] = {text = {"What are you looking at, huh?"},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [2] = {text = {"Why aren't you working?", "We don't pay you to stand around and chat.", "You're going to make up for this by \nworking overtime tonight.",
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
                logic = {next = 1, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Agave = {[1] = {text = {"It's nice to see you, but we'll get in \ntrouble if they see us talking.", "Let's chat after dinner ok?"},
                logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Tarragon = {[1] = {text = {"Go away."},
                logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Robin = {[1] = {text = {"Shouldn't you be working?"},
                logic = {next = 1, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        }
  },
  [1]= {
  -- Fennel = {[1] = {
  --                 text = {""},
  --                 logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1}} -- say once
  --       }, -- repeat
  Mint = {[1] = {text = {"Oh you got in trouble too huh?", "Guess this means we both missed\nsupper. Too bad.", "If only these berries weren't\npoisonous..."},
                logic = {next = 2, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}}, -- say once
          [2] = {text = {"Ugh, I'm so hungry..."},
               logic = {next = 1, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Lark = {[1] = {text = {"Hope you learned your lesson."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Finch = {[1] = {text = {"Boss says if you pick 60 berries you\ncan leave.", "Make sure you drop them in the barrels or it won't count."},
                logic = {next = 2, speaker = "Finch", cond = true, off = true, display = 1}},
           [2] = {text = {"You haven't filled your quota yet."},
                logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1}},
           [3] = {text = {"Ughh finally. What took you so long?"},
                logic = {next = 3, speaker = "Finch", cond = true, off = true, display = 1}},
           [4] = {text = {"Those berries don't belong to you.", "Better drop them in the barrels or\nyou'll be in biiig trouble."},
                logic = {next = 4, speaker = "Finch", cond = true, off = true, display = 1}},
           [5] = {text = {"Day's over. Go back to whatever hole you crawled out of."},
               logic = {next = 5, speaker = "Finch", cond = true, off = true, display = 1}}
        },
  Cress = {[1] = {text = {"Oh, uh, hi " ..player.name.. ". Happy birthday. Sorry they made you work late."},
                logic = {next = 2, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0}},
          [2] = {text = {"It's not your fault.", "Lark is the worst."},
                logic = {next = 3, offset = 2, speaker = "player", cond = true, off = false, display = 2}},
          [3] = {text = {"I know, but I still feel bad."},
                logic = {next = 5, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0}},
          [4] = {text = {"Yeah..."},
                logic = {next = 5, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0}},
          [5] = {text = {"Hopefully tomorrow will be better."},
                logic = {next = 5, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Agave = {[1] = {text = {"Oh there you are! I was worried they'd keep you all night.", "Don't worry we saved some dinner for you. And Mint too."},
                logic = {next = 2, speaker = "Agave", cond = true, off = false, display = 1, spoken = 0,}},
          [2] = {text = {"Wow, thank you! How did you get it?", "They're usually so strict about food."},
                logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0}},
          [3] = {text = {"Let's just say it was a group effort.", "You need to eat at least one meal a day to keep your strength up!", "Try not to get in trouble too often or you'll go hungry."},
                logic = {next = 3, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, func = charGivesObject, par = {"I got 1 Rat Soup.\n(Press I to open inventory.)", "Rat Soup", 1, "platefull2", false}}}
          },
  Tarragon = {[1] = {text = {"Leave me alone, I'm busy."},
                  logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Robin = {[1] = {text = {"Whatever it is, I'm not interested."},
                logic = {next = 1, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0}}
        },
  Durian = {[1] = {text = {"Another admirer huh?", "Oh, it's just Pisshead. Hah, never mind."},
                logic = {next = 1, speaker = "Durian", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        }
  },
  [2]= {
  -- Fennel = {[1] = {
  --                 text = {""},
  --                 logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1}} -- say once
  --       }, -- repeat
  Mint = {[1] = {text = {"I don't think Lark likes me very much." , "He makes me work overtime almost every day."},
                logic = {next = 1, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}} -- say once
        },
  Finch = {[1] = {text = {"Day's over. Go back to whatever hole you crawled out of."},
               logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Cress = {[1] = {text = {"You must be hungry after such a long day.","Were you able to get something to eat?"},
                logic = {next = 2, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0}},
          [2] = {text = {"Yeah Agave saved some food for me."},
                logic = {next = 3, offset = 2, speaker = "player", cond = true, off = false, display = 1}},
          [3] = {text = {"Oh good, I'm glad."},
                logic = {next = 3, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Agave = {[1] = {text = {"You should probably get to the dormitory.", "Don't let them catch you hanging around here after clean-up."},
                logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
          },
  Tarragon = {[1] = {text = {"..."},
                  logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Robin = {[1] = {text = {"What are you doing on the men's side?", "Go hang out with the girls and braid your hair", "or whatever it is females do with their spare time."},
                logic = {next = 2, speaker = "Robin", cond = true, off = false, display = 1, spoken = 0}},
          [2] = {text = {"Females...? You've got to be kidding."},
                logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0}},
          [3] = {text = {"It's what you are isn't it?"},
                logic = {next = 1, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Durian = {[1] = {text = {"Oh look it's another loser. Get out of here.", "Can't you see the adults are talking?"},
                logic = {next = 1, speaker = "Durian", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        }
  }
}


objectText = {
  gardeningSign = {"Field Supplies"},
  kitchenSign = {"Dining Hall"},
  dormitorySign = {"Dormitory"},
  storeSign = {"The Shiny Coin: Your Friendly Local Store and Tavern"},
  gardeningShed = {"It's locked."},
  playerBed = {"It's my bed.", "I still have things to do."},
  dormitory = {"It's locked."},
  dininghall = {"It's locked."},
  store = {"It's locked."},
  barrelSmBerriesStatic = {"Berries in barrel: " .. objectInventory["barrelSmBerries"]},
  barrelLgBerriesStatic = {"Berries in barrel: " .. objectInventory["barrelLgBerries"]},
  plantSm = {"The berries have already been harvested from this plant."},
  plantSmBerries = {"Press Z to Harvest Plum Berries", "...", "I'm too tired to work.", "I can't carry any more."},
  plantLg = {"The berries have already been harvested from this plant."},
  plantLgBerries = {"Press Z to Harvest Rose Berries", "...", "I'm too tired to work.", "I can't carry any more."},
  barrelSmBerries = {"Press Z to drop the Plum Berries in the Barrel"},
  barrelLgBerries = {"Press Z to drop the Rose Berries in the Barrel"},
  stool = {"Sit?"},
  platefull2 = {"I feel much better now."}
  }

journalText = {[1]= {"Day 1, daytime - Lark made me stay late today. He says I'm not working hard enough, but all he does is sit around and yell at people. Luckily Agave and the others saved some food for me."}
}
