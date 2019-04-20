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
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1, statmod = 1, statpar = {"Mint", "trust", "player", 5}}},
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
  Cress = {[1] = {text = {"Oh, uh, hi " ..player.name.. ". Sorry they made you work late."},
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
          [2] = {text = {"Wow, thank you! How did you get this?", "They're usually so strict about food."},
                logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0}},
          [3] = {text = {"Let's just say it was a group effort.", "You need to eat at least two meals a day to keep your strength up!", "Try not to get in trouble too often or you'll go hungry."},
                logic = {next = 3, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, func = charGivesObject, par = {"I got 2 Meat Soups.\n(Press I to open inventory.)", "Meat Soup", 2, "platefull2", false}}},

          },
  Tarragon = {[1] = {text = {"Leave me alone, I'm busy."},
                  logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Robin = {[1] = {text = {"Whatever it is, I'm not interested."},
                logic = {next = 1, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0}}
        },
  Durian = {[1] = {text = {"Another admirer huh?", "Oh, it's just you. Hah, never mind."},
                logic = {next = 1, speaker = "Durian", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Brier = {[1] = {text = {"Have you eaten yet?", "If not you should go talk to Agave in the dining hall."},
                logic = {next = 1, speaker = "Brier", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Lotus = {[1] = {text = {"Shhh. I'm in the middle of a water ceremony. Please don't interrupt."},
                logic = {next = 1, speaker = "Lotus", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Eucalyptus = {[1] = {text = {"Sorry sprout, dinner's over."},
                logic = {next = 1, speaker = "Eucalyptus", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Hawk = {[1] = {text = {"Stop sneaking around."},
                logic = {next = 1, speaker = "Hawk", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        }
  },
  [2]= {
  -- Fennel = {[1] = {
  --                 text = {""},
  --                 logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1}} -- say once
  --       }, -- repeat
  Mint = {[1] = {text = {"I don't think Lark likes me very much." , "He makes me work overtime almost every day."},
                logic = {next = 2, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1, func = changeDialogue, par = {"Meat Soup", 2, "Mint", 1, 4}}}, -- say once
          [2] = {text = {"I've got food for you.", "*say nothing*"},
                logic = {next = 6, offset = 2, speaker = "player", cond = true, off = false, display = 2}},
          [3] = {text = {"Agave gave it to me."},
                logic = {next = 5, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 1, statmod = 1, statpar = {"Mint", "trust", "player", 5}, func = charGivesObject, par = {"I gave away 1 Meat Soup", "Meat Soup", -1, "platefull2", false}}},
          [4] = {text = {"You must be really hungry too.", "I wish I had some food to share with you, like a big juicy steak.", "Not that I have any idea what steak tastes like.", "Maybe it's actually gross, and people just pretend to like it?", ".. haha I'm kidding, of course steak is good.", "It's just easier to believe it's not, you know?"},
                logic = {next = 6, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [5] = {text = {"Wow, thank you!"},
                logic = {next = 6, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [6] = {text = {"*yawn* Well, guess it's time for bed."},
                logic = {next = 6, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Finch = {[1] = {text = {"Day's over. Go back to whatever hole you crawled out of."},
               logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Cress = {[1] = {text = {"Have you seen Fennel?", "She said she was going to get something, but it's getting late."},
                logic = {next = 2, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0}},
          [2] = {text = {"No, I haven't."},
                logic = {next = 3, offset = 2, speaker = "player", cond = true, off = false, display = 1}},
          [3] = {text = {"I'll go look for her.", "I'm sure she'll turn up."},
                logic = {next = 4, offset = 3, speaker = "player", cond = true, off = false, display = 2}},
          [4] = {text = {"Ok, I hope she's ok."},
                logic = {next = 6, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1, statmod = 1, statpar = {"Cress", "trust", "player", 5}}},
          [5] = {text = {"Yeah..."},
                logic = {next = 6, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [6] = {text = {"Any sign of Fennel?"},
                logic = {next = 7, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0, energy = 1}},
          [7] = {text = {"Not yet."},
                logic = {next = 6, speaker = "player", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Agave = {[1] = {text = {"You should probably get to the dormitory.", "Don't let them catch you hanging around here after dark."},
                logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
          },
  Tarragon = {[1] = {text = {"..."},
                  logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Robin = {[1] = {text = {"What are you doing on the men's side?", "Females aren't allowed here."},
                logic = {next = 2, speaker = "Robin", cond = true, off = false, display = 1, spoken = 0}},
          [2] = {text = {"Females...? You've got to be kidding."},
                logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0}},
          [3] = {text = {"What? It's what you are isn't it?"},
                logic = {next = 4, speaker = "Robin", cond = true, off = false, display = 1, spoken = 0}},
          [4] = {text = {"Never mind.", "I'm not an animal...", "That's it, you're going down."},
                logic = {next = 5, offset = 4, speaker = "player", cond = true, off = false, display = 2}},
          [5] = {text = {"Running away huh? Typical."},
                logic = {next = 9, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 3}}, -- respond to player options
          [6] = {text = {"Really? Could have fooled me. You look like a dog.", "Right Tarragon?"},
                logic = {next = 8, speaker = "Durian", cond = true, off = false, display = 1, spoken = 0, energy = 3}}, -- respond to player options
          [7] = {text = {"Hahaha yeah right, you're just a girl.", "What are you going to do? Cry on us?"},
                logic = {next = 9, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 3}}, -- respond to player options
          [8] = {text = {"Yeah, um, that's right..."},
                logic = {next = 9, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 3}}, -- respond to player options
          [9] = {text = {"Ugh girls are so chatty."},
                logic = {next = 8, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0}}, -- respond to player options
      },
  Durian = {[1] = {text = {"Get out of here pipsqueak. Can't you see the adults are talking?"},
                logic = {next = 1, speaker = "Durian", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Brier = {[1] = {text = {"I hope we don't run out of wood.", "The days are hot but the nights are still chilly."},
                logic = {next = 1, speaker = "Brier", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Lotus = {[1] = {text = {"Is it just me or does it smell funny in here?", "I can't tell if it's the mould or someone's feet.", "Can I smell your... wait, that would be weird wouldn't it?", "Nevermind."},
                logic = {next = 2, speaker = "Lotus", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
           [2] = {text = {"*sniff* *sniff*"},
                logic = {next = 2, speaker = "Lotus", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Eucalyptus = {[1] = {text = {"Sorry sprout, dinner's over."},
                logic = {next = 1, speaker = "Eucalyptus", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Hawk = {[1] = {text = {"Stop sneaking around."},
                logic = {next = 1, speaker = "Hawk", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        }
  },
  [3]= {
  Fennel = {[1] = {text = {player.name.. "!", "W-wake up, please! I.. something bad happened."},
                  logic = {next = 2, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0}}, -- say once
            [2] = {text = {"Huh... what's going on? Are you ok?"},
                  logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [3] = {text = {"No, I... After dinner, I went to the edge of the woods..", "To get your gift for your sprout day tomorrow.", "L..Lark was there, just sitting there. Like he was waiting for me.", "He acted nice...at first, not like his usual self.", "He told me he appreciated how hard I worked..", "And that he wanted to reward me. He said he got a bottle of wine...", "Fancy stuff, imported all the way from Flora. He wanted me to try it.",
            "'To make sure it's good,' he said. At least, I think that's what he said.", "I didn't want to take it at first. I said no, but he insisted.", "And since he's our boss, I.. I was afraid to say no twice.", "So I took a sip. As soon as I did, my vision started getting fuzzy..", "I don't remember what happened after that.", "When I woke up, I was sore all over. Lark was gone.", "And also the flower... it... i-it was crushed.",
            "The one I'd been growing for you secretly all spring.", "It was supposed to be your present..."},
                  logic = {next = 4, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [4] = {text = {"Oh no.. Fennel I'm so sorry. "},
                  logic = {next = 5, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [5] = {text = {"It's my fault. I shouldn't have gone alone.", "I should have left once I saw Lark was there.", "It was stupid. I...I should know better."},
                  logic = {next = 6, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [6] = {text = {"Yeah, maybe that was a bad idea.", "It's not your fault!"},
                  logic = {next = 7, offset = 6, speaker = "player", cond = true, off = false, display = 2, spoken = 0, energy = 0}},
            [7] = {text = {"I'm sorry. Your gift is ruined now...", "And I woke you up in the middle of the night.", "I'm such an idiot."},
                  logic = {next = 9, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0, statmod = 1, statpar = {"Fennel", "trust", "player", -10}}},
            [8] = {text = {"T-thank you.. Maybe it doesn't make much sense, but I feel so ashamed."},
                  logic = {next = 9, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0, statmod = 1, statpar = {"Fennel", "trust", "player", 10}}},
            [9] = {text = {"So, what do we do now?"},
                  logic = {next = 10, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [10] = {text = {"I... I don't know."},
                  logic = {next = 10, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 0}}
        }, -- repeat
  },
  [4]= {
  Fennel = {[1] = {
                  text = {"Sorry I don't feel like talking right now."},
                  logic = {next = 1, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1}} -- say once
        }, -- repeat
  Mint = {[1] = {text = {"I think it's even hotter than yesterday."},
                logic = {next = 1, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}}, -- say once
        },
  Lark = {[1] = {text = {"What are you looking at, huh?"},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [2] = {text = {"Why aren't you working?", "We don't pay you to stand around and chat.", "You're going to make up for this by \nworking overtime tonight.",
                "Now GET MOVING! ... stupid lazy\nmudskins..."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0}}
          -- [4] = {text = {"Hah, get ready to lose, loser.", "Too bad."},
          --       logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 3, trigger = {type = "battle", choice = 1}}},
        },
  Finch = {[1] = {text = {"You're late, slacker.", "Better get to work if you're going to meet your daily quota."},
                logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1}}
        },
  Cress = {[1] = {text = {"Fennel came back, I'm glad. I hope everything's ok."},
                logic = {next = 1, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Brier = {[1] = {text = {"You're late. Did you not sleep well? You look tired.", "Better run to the mess hall or you'll miss breakfast."},
                logic = {next = 1, speaker = "Brier", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Agave = {[1] = {text = {"It's nice to see you, but we'll get in \ntrouble if they see us talking.", "Let's chat after dinner ok?"},
                logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Tarragon = {[1] = {text = {"Go away."},
                logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Robin = {[1] = {text = {"Buzz off, slacker. Some of us are trying to work here."},
                logic = {next = 1, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Lotus = {[1] = {text = {"The section manager is coming tomorrow for his weekly speech.", "I think this is it, this is the week I finally get my promotion."},
                logic = {next = 1, speaker = "Lotus", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
           [2] = {text = {"What makes you think that?"},
               logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
           [3] = {text = {"I performed a water divination ceremony yesterday", "The ripples told me I should 'expect great things'", "The tides are changing, I can feel it."},
               logic = {next = 2, speaker = "Lotus", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
           [4] = {text = {"I performed a water divination ceremony yesterday", "The ripples told me I should 'expect great things'", "The tides are changing, I can feel it."},
               logic = {next = 2, speaker = "Lotus", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },

  }
}


objectText = {
  gardeningSign = {text = {"Field Supplies"}, logic = {off = false}},
  kitchenSign = {text = {"Dining Hall"}, logic = {off = false}},
  dormitorySign = {text = {"Dormitory"}, logic = {off = false}},
  storeSign = {text = {"The Shiny Coin: Your Friendly Local Store and Tavern"}, logic = {off = false}},
  gardeningShed = {text = {"It's locked."}, logic = {off = false}},
  playerBed = {text = {"It's my bed.", "I still have things to do.", "Time for bed?"}, logic = {off = false, yesno = false}},
  dormitory = {text = {"It's locked."}, logic = {off = false}},
  dininghall = {text = {"It's locked."}, logic = {off = false}},
  store = {text = {"It's locked."}, logic = {off = false}},
  barrelSmBerriesStatic = {text = {"Berries in barrel: " .. objectInventory["barrelSmBerries"]}, logic = {off = false}},
  barrelLgBerriesStatic = {text = {"Berries in barrel: " .. objectInventory["barrelLgBerries"]}, logic = {off = false}},
  plantSm = {text = {"The berries have already been harvested from this plant."}, logic = {off = false}},
  plantSmBerries = {text = {"I got 1 Plum Berry.", "That's the last one.", "I'm too tired to work.", "I can't carry any more."}, logic = {off = false}},
  plantLg = {text = {"The berries have already been harvested from this plant."}, logic = {off = false}},
  plantLgBerries = {text = {"I got 1 Rose Berry.", "That's the last one.", "I'm too tired to work.", "I can't carry any more."}, logic = {off = false}},
  barrelSmBerries = {text = {"Press Z to drop the Plum Berries in the Barrel"}, logic = {off = false}},
  barrelLgBerries = {text = {"Press Z to drop the Rose Berries in the Barrel"}, logic = {off = false}},
  platefull2 = {text = {"I feel much better now."}, logic = {off = false}},
  yesno = {text = {"Yes", "No"}, logic = {off = false}}
  }

itemDescription = {plantSmBerries = "One of the main ingredients used in potions. Very poisonous unless properly prepared.",
                   plantLgBerries = "One of the main ingredients used in potions. Very poisonous unless properly prepared.",
                   platefull2 = "A thin soup made with an unidentified meat. Try not to think about it too hard."
}

journalText = {[1]= {"Day 1, daytime - Lark made me stay late today. He says I'm not working hard enough, but all he does is sit around and yell at people. Luckily Agave and the others saved some food for me."}
}
