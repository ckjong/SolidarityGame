-- for display, 1 = display one at a time, 2 = display all as options, 3 = display one of several options
-- put functions in condition to check if conditions filled

NPCdialogue = {
  [0]= {
  Fennel = {[1] = {
                  text = {"Oh hi "..player.name..".", "The foreman's giving you the evil eye, \nbetter get back to work.", "We'll talk later ok?"},
                  logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = addInfo, par = {"Very responsible, sometimes too responsible...", "Fennel"}}}, -- say once
          [2] = {text = {"Not now, I'll talk to you later."},
                logic = {next = 2, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1}} --repeat
        }, -- repeat
  Mint = {[1] = {text = {"Hi "..player.name..". This heat is intense, I think I'm going to pass out.", "I wish I could take a break but the \nforeman's watching."},
                logic = {next = 2, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = addInfo, par = {"Likes to complain about work.", "Mint"}}}, -- say once
          [2] = {text = {"There sure are a lot of berries to pick."},
                logic = {next = 3, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}},-- repeat
          [3] = {text = {"What's your favourite fish?"},
                logic = {next = 4, speaker = "Mint", cond = true, off = false, display = 1}}, -- player response
          [4] = {text = {"Carp", "Trout", "Salmon", "Bass", "Perch"},
                logic = {next = 10, offset = 4, speaker = "player", cond = true, off = false, display = 2}},
          [5] = {text = {"Oh good choice."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1}}, -- respond to player options
          [6] = {text = {"Me too!"},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1, trustmod = 1, statpar = {"Mint", "player", 5}}},
          [7] = {text = {"I thought so."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1}},
          [8] = {text = {"Cool!"},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1}},
          [9] = {text = {"I see..."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1, trustmod = 1, statpar = {"Mint", "player", -5}}},
          [10] = {text = {"Ok back to work I guess."},
                logic = {next = 10, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
        },
  Lark = {[1] = {text = {"What are you looking at, huh?"},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [2] = {text = {"Why aren't you working?", "We don't pay you to stand around and chat.", "You're going to make up for this by \nworking overtime tonight.",
                "Now GET MOVING! ... stupid lazy\nweeds..."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0, func = addInfo, par = {"The worst.", "Lark"}}}
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
               logic = {next = 2, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Lark = {[1] = {text = {"Hope you learned your lesson."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Finch = {[1] = {text = {"Boss says if you pick 60 berries you\ncan leave.", "Make sure you drop them in the barrels or it won't count."},
                logic = {next = 2, speaker = "Finch", cond = true, off = true, display = 1}},
           [2] = {text = {"You haven't filled your quota yet."},
                logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1}},
           [3] = {text = {"You're done? Ughh finally. What took you so long?"},
                logic = {next = 3, speaker = "Finch", cond = true, off = true, display = 1, func = addInfo, par = {"An annoying bully.", "Finch"}}},
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
                logic = {next = 6, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [6] = {text = {"Oh I almost forgot, you should go talk to Agave.", "She should be in the dining hall."},
                logic = {next = 6, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Agave = {[1] = {text = {"Oh there you are! I was worried they'd keep you all night.", "Don't worry we saved some dinner for you. And Mint too."},
                logic = {next = 2, speaker = "Agave", cond = true, off = false, display = 1, spoken = 0, func = addInfo, par = {"Kind, often looks out for the younger field hands.", "Agave"}}},
          [2] = {text = {"Wow, thank you! How did you get this?", "They're usually so strict about food."},
                logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0}},
          [3] = {text = {"Let's just say it was a group effort.", "You need to eat at least two meals a day to keep your strength up!", "Try not to get in trouble too often or you'll go hungry."},
                logic = {next = 3, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, func = charGivesObject, par = {"I got 2 Thin Soups.\n(Press I to open inventory.)", "Thin Soup", 2, "platefull2", false}}},

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
  Euca = {[1] = {text = {"Sorry sprout, dinner's over."},
                logic = {next = 1, speaker = "Euca", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
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
                logic = {next = 2, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1, func = changeDialogueNext, par = {"platefull2", 2, "Mint", 1, 4}}}, -- say once
          [2] = {text = {"I brought you some dinner.", "*say nothing*"},
                logic = {next = 6, offset = 2, speaker = "player", cond = true, off = false, display = 2}},
          [3] = {text = {"Agave gave it to me."},
                logic = {next = 5, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 1, trustmod = 1, statpar = {"Mint", "player", 5}, func = charGivesObject, par = {"I gave away 1 Thin Soup", "Thin Soup", -1, "platefull2", false}}},
          [4] = {text = {"You must be starving too.", "I wish I had some food to share with you, like a big juicy steak.", "Not that I have any idea what steak tastes like.", "Maybe it's actually gross, and people just pretend to like it?", ".. haha I'm kidding, of course steak is good.", "It's just easier to believe it's not, you know?"},
                logic = {next = 6, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = addInfo, par = {"Empathetic.", "Mint"}}},
          [5] = {text = {"Wow, thank you! Please tell her I said thanks!"},
                logic = {next = 6, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [6] = {text = {"*yawn* Well, guess it's time for bed."},
                logic = {next = 6, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = updateUI, par = {"bedArrow", true, "Mint"}}}
        },
  Finch = {[1] = {text = {"Day's over. Go back to whatever hole you crawled out of."},
               logic = {next = 1, speaker = "Finch", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Cress = {[1] = {text = {"Have you seen Fennel?", "She said she was going to get something, but it's getting late."},
                logic = {next = 2, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0, func = addInfo, par = {"Notices things others miss.", "Cress"}}},
          [2] = {text = {"No, I haven't."},
                logic = {next = 3, offset = 2, speaker = "player", cond = true, off = false, display = 1, spoken = 0, func = changeDialogue, par = {"Brier", 2}}},
          [3] = {text = {"I'll go look for her.", "I'm sure she'll turn up."},
                logic = {next = 4, offset = 3, speaker = "player", cond = true, off = false, display = 2}},
          [4] = {text = {"Ok, I hope she's ok."},
                logic = {next = 6, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1, trustmod = 1, statpar = {"Cress", "player", 5}}},
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
                  logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = addInfo, par = {"Doesn't talk much, hard to read.", "Tarragon"}}}
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
                logic = {next = 9, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 3, func = addInfo, par = {"Mean, especially to girls.", "Robin"}}}, -- respond to player options
          [6] = {text = {"Really? Could have fooled me. You look like a dog.", "Right Tarragon?"},
                logic = {next = 8, speaker = "Durian", cond = true, off = false, display = 1, spoken = 0, energy = 3, func = addInfo, par = {"Huge jerk.", "Durian"}}}, -- respond to player options
          [7] = {text = {"Hahaha yeah right, you're just a girl.", "What are you going to do? Cry on us?"},
                logic = {next = 9, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 3, func = addInfo, par = {"Mean, especially to girls.", "Robin"}}}, -- respond to player options
          [8] = {text = {"Yeah, um, that's right..."},
                logic = {next = 9, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 3}}, -- respond to player options
          [9] = {text = {"Ugh girls are so chatty."},
                logic = {next = 9, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0}}, -- respond to player options
      },
  Durian = {[1] = {text = {"Get out of here pipsqueak. Can't you see the adults are talking?"},
                logic = {next = 1, speaker = "Durian", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Brier = {[1] = {text = {"Shouldn't you be heading to bed soon?"},
                logic = {next = 1, speaker = "Brier", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = updateUI, par = {"bedArrow", true, "Brier"}}},
          [2] = {text = {"Have you seen Fennel?"},
                logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 1}},
          [3] = {text = {"I saw her leave the compound earlier.", "But it's too late to be wandering around.", "Don't worry, I'll stay here and wait for her to come back.", "You should head to bed.", "You don't want to be tired for work tomorrow."},
                logic = {next = 1, speaker = "Brier", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Lotus = {[1] = {text = {"Is it just me or does it smell funny in here?", "I can't tell if it's the mould or someone's feet.", "Can I smell your... wait, that would be weird wouldn't it?", "Never mind."},
                logic = {next = 2, speaker = "Lotus", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = addInfo, par = {"A bit strange.", "Lotus"}}},
           [2] = {text = {"*sniff* *sniff*", "Seems like the smell is stronger over on your side of the room."},
                logic = {next = 2, speaker = "Lotus", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Euca = {[1] = {text = {"Sorry sprout, dinner's over."},
                logic = {next = 1, speaker = "Euca", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Hawk = {[1] = {text = {"Stop sneaking around."},
                logic = {next = 1, speaker = "Hawk", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        }
  },
  [3]= {},
  -- Fennel = {[1] = {text = {player.name.. "!", "W-wake up, please! I.. something bad happened."},
  --                 logic = {next = 2, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0}}, -- say once
  --           [2] = {text = {"Huh... what's going on? Are you ok?"},
  --                 logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
  --           [3] = {text = {"No, I... After dinner, I went to the edge of the woods..", "To get your gift for your sprout day tomorrow.", "L..Lark was there, just sitting there. Like he was waiting for me.", "He acted nice...at first, not like his usual self.", "He told me he appreciated how hard I worked..", "And that he wanted to reward me. He said he got a bottle of wine...", "Fancy stuff, imported all the way from Flora. He wanted me to try it.",
  --           "'To make sure it's good,' he said. At least, I think that's what he said.", "I didn't want to take it at first. I said no, but he insisted.", "And since he's our boss, I.. I was afraid to say no twice.", "So I took a sip. As soon as I did, my vision started getting fuzzy..", "I don't remember what happened after that.", "When I woke up, I was sore all over. Lark was gone.", "And also the flower... it... i-it was crushed.",
  --           "The one I'd been growing for you secretly all spring.", "It was supposed to be your present..."},
  --                 logic = {next = 4, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
  --           [4] = {text = {"Oh no.. Fennel I'm so sorry. "},
  --                 logic = {next = 5, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
  --           [5] = {text = {"It's my fault. I shouldn't have gone alone.", "I should have left once I saw Lark was there.", "It was stupid. I...I should know better."},
  --                 logic = {next = 6, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
  --           [6] = {text = {"Yeah, maybe that was a bad idea.", "It's not your fault!"},
  --                 logic = {next = 7, offset = 6, speaker = "player", cond = true, off = false, display = 2, spoken = 0, energy = 0}},
  --           [7] = {text = {"I'm sorry. Your gift is ruined now...", "And I woke you up in the middle of the night.", "I'm such an idiot."},
  --                 logic = {next = 9, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0, statmod = 1, statpar = {"Fennel", "trust", "player", -10}}},
  --           [8] = {text = {"T-thank you.. Maybe it doesn't make much sense, but I feel so ashamed."},
  --                 logic = {next = 9, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0, statmod = 1, statpar = {"Fennel", "trust", "player", 10}}},
  --           [9] = {text = {"So, what do we do now?"},
  --                 logic = {next = 10, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
  --           [10] = {text = {"I... I don't know."},
  --                 logic = {next = 10, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 0}}
  --       }, -- repeat
  -- },
  [4]= {
  Fennel = {[1] = {
                  text = {"Sorry, I don't feel like talking right now."},
                  logic = {next = 2, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 1}}, -- say once
            [2] = {text = {"Oh, ok.", "Where were you last night?"},
                  logic = {next = 3, offset = 2, speaker = "player", cond = true, off = false, display = 2}},
            [3] = {text = {"Let's head to the dining hall."},
                  logic = {next = 5, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 0, trustmod = 1, statpar = {"Fennel", "player", 5}, func = addParty, par = {"Fennel"}}},
            [4] = {text = {"I.. look, let's just get to work ok? We're already late."},
                  logic = {next = 3, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [5] = {text = {"We shouldn't talk here."},
                  logic = {next = 5, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        }, -- repeat
  Mint = {[1] = {text = {"I think it's even hotter than yesterday."},
                logic = {next = 1, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}} -- say once
        },
  Lark = {[1] = {text = {"Get back to work."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [2] = {text = {"DAY'S OVER!"},
                logic = {next = 2, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0, energy = 0}}
        },
  Finch = {[1] = {text = {"You're late, slacker.", "Better get to work if you're going to meet your daily quota.", "Boss says you need 60 berries."},
                logic = {next = 2, speaker = "Finch", cond = true, off = true, display = 1, func = changeQuota, par = {"Finch", 60}}},
           [2] = {text = {"You haven't filled your quota yet.", "You need at least 60 berries in those barrels before you can leave."},
                logic = {next = 2, speaker = "Finch", cond = true, off = true, display = 1}},
           [3] = {text = {"You better not be trying to steal any berries."},
                logic = {next = 3, speaker = "Finch", cond = true, off = true, display = 1}},
           [4] = {text = {"Those berries don't belong to you.", "Better drop them in the barrels or\nyou'll be in biiig trouble."},
                logic = {next = 4, speaker = "Finch", cond = true, off = true, display = 1}},
           [5] = {text = {"Day's over. Go back to whatever hole you crawled out of."},
               logic = {next = 5, speaker = "Finch", cond = true, off = true, display = 1}}
        },
  Cress = {[1] = {text = {"Fennel came back, I'm glad. I hope everything's ok."},
                logic = {next = 2, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
          [2] = {text = {"I guess we should get breakfast."},
                logic = {next = 3, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = addParty, par = {"Cress"}}},
          [3] = {text = {"Ouch, I pricked myself again."},
                logic = {next = 3, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 0}}
        },
  Brier = {[1] = {text = {"You're late. Did you not sleep well? You look tired.", "Better run to the mess hall or you'll miss breakfast."},
                logic = {next = 1, speaker = "Brier", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Agave = {[1] = {text = {"Try not to get in trouble this time ok?"},
                logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Tarragon = {[1] = {text = {"Go away."},
                logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Durian = {[1] = {text = {"Moving the water barrels is one of the hardest jobs you know?", "Good thing I'm incredibly strong."},
                logic = {next = 2, speaker = "Durian", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = addInfo, par = {"Full of himself.", "Durian"}}},
            [2] = {text = {"*grunts*"},
                          logic = {next = 2, speaker = "Durian", cond = true, off = true, display = 1, spoken = 0, energy = 0}},
        },
  Robin = {[1] = {text = {"Buzz off. Some of us are trying to work here."},
                logic = {next = 1, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Lotus = {[1] = {text = {"The compound manager is coming tonight for her weekly speech.", "I think this is it, this is the week I finally get my promotion."},
                logic = {next = 2, speaker = "Lotus", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
           [2] = {text = {"What makes you think that?"},
               logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
           [3] = {text = {"I performed a water divination ceremony yesterday.", "The ripples told me I should 'expect great things.'"},
               logic = {next = 4, speaker = "Lotus", cond = true, off = false, display = 1, spoken = 0, energy = 0, func = addInfo, par = {"Ambitious.", "Lotus"}}},
           [4] = {text = {"The tides are changing, I can feel it."},
               logic = {next = 4, speaker = "Lotus", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Hawk = {[1] = {text = {"Late again huh? Why am I not surprised."},
                logic = {next = 1, speaker = "Hawk", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Euca = {[1] = {text = {"Hey you almost missed breakfast!", "If you can even call that slop breakfast..."},
                logic = {next = 1, speaker = "Euca", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = charGivesObject, par = {"I got 1 Bowl of Gruel", "Bowl of Gruel", 1, "platefull3", false}}}
        }
  },
  [5]= {
  Fennel = {[1] = {text = {"Hey..."},
                  logic = {next = 1, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 1}} -- say once
        }, -- repeat
  Mint = {[1] = {text = {"Yay supper! This is my favourite part of the day.", "It's nice to not be working overtime for a change.", "Lark seems to be in a good mood for once. I wonder why...", "Well I guess we should go get our food."},
                logic = {next = 2, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = addParty, par = {"Mint"}}},
          [2] = {text = {"Geez I can't remember the last time I got to eat supper with everyone."},
                logic = {next = 3, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 1}},
          [3] = {text = {"You shouldn't let Lark push you around like that!", "He's always making you work late for no reason!"},
                logic = {next = 4, speaker = "Fennel", cond = true, off = false, display = 1, spoken = 0, energy = 0}}, -- say once
          [4] = {text = {"He says I'm too slow. Maybe he's right...", "Besides, if I don't do what he says he'll just get even angrier."},
                logic = {next = 5, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
          [5] = {text = {"Fennel is right.", "Mint is right.", "Maybe we can help?"},
                logic = {next = 6, offset = 5, speaker = "player", cond = true, off = false, display = 2}},
          [6] = {text = {"Don't worry about me. I'll be ok."},
                logic = {next = 9, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 0}},
          [7] = {text = {"Ugh nevermind. Forget I said anything."},
                logic = {next = 9, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 0}},
          [8] = {text = {"Oh, that would be great!", "I would feel a lot braver if I had backup.", "I'm still not sure what we can do though..."},
                logic = {next = 10, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
          [9] = {text = {"Oh look I found a bug in my soup."},
                logic = {next = 9, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [10] = {text = {"I don't know.", "We'll think of something."},
                logic = {next = 9, offset = 10, speaker = "player", cond = true, off = false, display = 2}},
          [11] = {text = {"Oh. That's too bad."},
                logic = {next = 9, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 0}},
          [12] = {text = {"You're right. Thanks."},
                logic = {next = 9, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 0}},
        },
  Lotus = {[1] = {text = {"I can't wait for the floor meeting! Ani is so cool.", "It's so rare to see a woman in her position."},
                logic = {next = 1, speaker = "Lotus", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
  },
  Finch = {[1] = {text = {"Boss says you need 60 berries."},
                logic = {next = 2, speaker = "Finch", cond = true, off = true, display = 1}},
           [2] = {text = {"You haven't filled your quota yet.", "You need at least 60 berries in those barrels before you can leave."},
                logic = {next = 2, speaker = "Finch", cond = true, off = true, display = 1}},
           [3] = {text = {"You better not be trying to steal any berries."},
                logic = {next = 3, speaker = "Finch", cond = true, off = true, display = 1}},
           [4] = {text = {"Those berries don't belong to you.", "Better drop them in the barrels or\nyou'll be in biiig trouble."},
                logic = {next = 4, speaker = "Finch", cond = true, off = true, display = 1}},
           [5] = {text = {"Day's over. Go back to whatever hole you crawled out of."},
               logic = {next = 5, speaker = "Finch", cond = true, off = true, display = 1}}
        },
  Lark = {[1] = {text = {"Get out of here.", "I have better things to do than watch you laze around all day."},
                logic = {next = 1, speaker = "Lark", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [2] = {text = {"Day's over! Get to the dining hall for the floor meeting."},
                logic = {next = 2, speaker = "Lark", cond = true, off = true, display = 1}}
        },
  Cress = {[1] = {text = {"I'm so tired. I hope I don't fall asleep at the table."},
                logic = {next = 2, speaker = "Cress", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
           [2] = {text = {"Isn't there a floor meeting tonight?"},
               logic = {next = 3, speaker = "Mint", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
           [3] = {text = {"Oh right, I almost forgot...", "I wish I could skip it, but I can't afford to lose a week of pay."},
               logic = {next = 4, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
           [4] = {text = {"*snoring* Hm, what? No I'm awake. I swear."},
                logic = {next = 4, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
        },
  Brier = {[1] = {text = {"Did you know there used to be a village here?", "Before the factory was built, this was the old guild hall."},
                logic = {next = 1, speaker = "Brier", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Agave = {[1] = {text = {"Oof, it feels good to sit down."},
                logic = {next = 2, speaker = "Agave", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
           [2] = {text = {"Are you ok?"},
                logic = {next = 3, speaker = "player", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
           [3] = {text = {"Oh don't worry I'll be fine. Just some creaky old bones."},
                logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
        },
  Tarragon = {[1] = {text = {"Go away."},
                logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Durian = {[1] = {text = {"Hey did you hear about the dock worker that went missing?", "He got sick so they sent him to see the alchemists.", "But he never came back to work..."},
                logic = {next = 2, speaker = "Durian", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [2] = {text = {"Those dock workers are all liars, cheaters, and drunks.", "They're probably just messing with you."},
                logic = {next = 3, speaker = "Robin", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [3] = {text = {"Yeah you're probably right... It's still weird though."},
                logic = {next = 4, speaker = "Durian", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [4] = {text = {"Maybe the forest monsters got him?"},
                logic = {next = 5, speaker = "Tarragon", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [5] = {text = {"Don't be stupid, those monsters don't exist.", "That's just an old wives' tale."},
                logic = {next = 6, speaker = "Robin", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [6] = {text = {"How would you know? You've never been in the woods."},
                logic = {next = 7, speaker = "Tarragon", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
            [7] = {text = {"Because unlike you I'm rational and don't believe in fairy tales."},
                logic = {next = 8, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
            [8] = {text = {"I wonder..."},
                logic = {next = 8, speaker = "Durian", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
        },
  Robin = {[1] = {text = {"Can't you see I'm eating? What's your problem?"},
                logic = {next = 1, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        },
  Euca = {[1] = {text = {"Here's your supper. I'd tell you to enjoy, but... yeah."},
                logic = {next = 1, speaker = "Euca", cond = true, off = true, display = 1, spoken = 0, energy = 1, func = charGivesObject, par = {"I got 1 Thin Soup", "Thin Soup", 1, "platefull2", false}}},
          [2] = {text = {"Sorry only one meal per person allowed."},
                 logic = {next = 2, speaker = "Euca", cond = true, off = true, display = 1, spoken = 0, energy = 0}}
        },
  Hawk = {[1] = {text = {"Get your food and take a seat.", "Ms. Ani will be arriving soon."},
                logic = {next = 2, speaker = "Hawk", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
          [2] = {text = {"Don't try anything sneaky. I've got my eye on you."},
                 logic = {next = 2, speaker = "Hawk", cond = true, off = true, display = 1, spoken = 0, energy = 0}}
        },
  Ani = {[1] = {text = {"Good evening everyone!", "I have some exciting announcements to make.", "As you know, the Purple Isle Potions family has been growing.", "We now have three new shops open on the mainland!", "All thanks to your hard work and dedication.", "And the visionary leadership of our esteemed founder, Sir Eagle Black."},
                logic = {next = 2, speaker = "Ani", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
         [2] = {text = {"The increased demand means we all have to up our game.", "Starting tomorrow, your daily quotas will be increased to 80.", "Yes, that might seem like a lot, but I know you'll make me proud!"},
                logic = {next = 3, speaker = "Ani", cond = true, off = false, display = 1, spoken = 0, energy = 0}},
         [3] = {text = {"This is a golden opportunity to show us what you're made of.", "Don't forget that I was once a humble field hand just like you.", "But with hard work and determination I rose through the ranks.", "That's how I became compound manager!", "Those that not only meet but exceed their quotas will be rewarded.", "Remember, we're more than a company, we're a family! ^_^"},
                logic = {next = 4, speaker = "Ani", cond = true, off = true, display = 1, spoken = 0, energy = 1}},
         [4] = {text = {"Is my hair ok?"},
                logic = {next = 4, speaker = "Ani", cond = true, off = true, display = 1, spoken = 0, energy = 1}}
        }
  },
  [6]= {
  Fennel = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Fennel", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Mint = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Mint", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Cress = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Cress", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Tarragon = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Tarragon", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Durian = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Durian", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Robin = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Robin", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Hawk = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Hawk", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Brier = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Brier", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Agave = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Agave", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Euca = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Euca", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  Ani = {[1] = {text = {"Looks like you reached the end of the demo.", "Time to restart."},
                  logic = {next = 1, speaker = "Ani", cond = true, off = true, display = 1, spoken = 0, energy = 0, func = quitGame, par = {"restart"}}} -- say once
        },
  }

}


objectText = {
  gardeningSign = {text = {"Field Supplies"}, logic = {off = false}},
  kitchenSign = {text = {"Dining Hall - Field Workers"}, logic = {off = false}},
  dormitorySign = {text = {"Dormitory - Field Workers"}, logic = {off = false}},
  storeSign = {text = {"The Shiny Coin: Your Friendly Local Store and Tavern"}, logic = {off = false}},
  gardeningShed = {text = {"It's locked."}, logic = {off = false}},
  playerBed = {text = {"It's my bed.", "I still have things to do.", "Time for bed?"}, logic = {off = false, yesno = false}},
  LotusBed = {text = {"This bed belongs to Lotus."}, logic = {off = false}},
  CressBed = {text = {"This bed belongs to Cress."}, logic = {off = false}},
  AgaveBed = {text = {"This bed belongs to Agave."}, logic = {off = false}},
  FennelBed = {text = {"This bed belongs to Fennel.", "This bed belongs to Fennel."}, logic = {off = false}},
  MintBed = {text = {"This bed belongs to Mint."}, logic = {off = false}},
  DurianBed = {text = {"This bed belongs to Durian.", "This bed belongs to Durian."}, logic = {off = false}},
  RobinBed = {text = {"This bed belongs to Robin.", "This bed belongs to Robin."}, logic = {off = false}},
  TarragonBed = {text = {"This bed belongs to Tarragon."}, logic = {off = false}},
  BrierBed = {text = {"This bed belongs to Brier."}, logic = {off = false}},
  EmptyBed = {text = {"This bed doesn't belong to anyone."}, logic = {off = false}},
  dormitory = {text = {"It's locked."}, logic = {off = false}},
  dininghall = {text = {"It's locked."}, logic = {off = false}},
  store = {text = {"It's locked."}, logic = {off = false}},
  barrelSmBerriesStatic = {text = {"Berries in barrel: " .. objectInventory["barrelSmBerries"]}, logic = {off = false}},
  barrelLgBerriesStatic = {text = {"Berries in barrel: " .. objectInventory["barrelLgBerries"]}, logic = {off = false}},
  plantSm = {text = {"The berries have already been harvested from this plant."}, logic = {off = true}},
  plantSmBerries = {text = {"I got 1 Plum Berry.", "That's the last one.", "I'm too tired to work.", "I can't carry any more."}, logic = {off = false}},
  plantLg = {text = {"The berries have already been harvested from this plant."}, logic = {off = true}},
  plantLgBerries = {text = {"I got 1 Rose Berry.", "That's the last one.", "I'm too tired to work.", "I can't carry any more."}, logic = {off = false}},
  barrelSmBerries = {text = {"Press Z to drop the Plum Berries in the Barrel"}, logic = {off = false}},
  barrelLgBerries = {text = {"Press Z to drop the Rose Berries in the Barrel"}, logic = {off = false}},
  platefull2 = {text = {"I feel much better now."}, logic = {off = false}},
  platefull3 = {text = {"I feel much better now."}, logic = {off = false}},
  yesno = {text = {"Yes", "No"}, logic = {off = false}}
  }

itemDescription = {plantSmBerries = "One of the main ingredients used in potions. Very poisonous unless properly prepared.",
                   plantLgBerries = "One of the main ingredients used in potions. Very poisonous unless properly prepared.",
                   platefull2 = "A thin soup made with an unidentified meat. Try not to think about it too hard.",
                   platefull3 = "A tasteless gruel. Better than nothing, but not by much."
}

journalText = {[1]= {"Day 1, daytime - Lark made me stay late today. He says I'm not working hard enough, but all he does is sit around and yell at people. Luckily Agave and the others saved some food for me."}
}
