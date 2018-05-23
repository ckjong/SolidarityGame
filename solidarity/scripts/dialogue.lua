-- for display, 1 = display one at a time, 2 = display all as options, 3 = display one of several options
-- put functions in condition to check if conditions filled
require("main")
speaker = 1

NPCdialogue = {
  Grape = {[1] = {
                  text = {"Oh hi.", "Did you see the giant cauliflowers?", "I can't wait to make soup!", "See you later!"},
                  logic = {next = 2, speaker = "Grape", cond = true, off = true, display = 1}}, -- say once
          [2] = {text = {"Have a great day!"},
                logic = {next = 2, speaker = "Grape", cond = true, off = true, display = 1}} --repeat
        }, -- repeat
  Lark = {[1] = {text = {"I love looking at the water, don't you?", "It's a bit too cold for swimming today."},
                logic = {next = 3, speaker = "Lark", cond = true, off = true, display = 1}}, -- say once
          [2] = {text = {"Have a great day!"},
                logic = {next = 2, speaker = "Lark", cond = true, off = true, display = 1}},-- repeat
          [3] = {text = {"What's your favourite fish?"},
                logic = {next = 4, speaker = "Lark", cond = true, off = false, display = 1}}, -- player response
          [4] = {text = {"Carp", "Trout", "Salmon", "Bass", "Perch"},
                logic = {next = 5, speaker = "player", cond = true, off = false, display = 2}},
          [5] = {text = {"Oh good choice.", "Me too!", "I thought so.", "Cool!", "I see."},
                logic = {next = 2, speaker = "Lark", off = false, display = 3}} -- respond to player options
        }
}


playerDialogue = {
  Lark = {[1] = {text = {"Carp", "Trout", "Salmon"},
  logic = {next = 4, cond = true, choice = 2}}
  }
}

objectText = {
  GardeningSign = "Gardening Supplies",
  KitchenSign = "Kitchen and Dining Hall",
  ClinicSign = "Health Clinic",
  Cauliflower = "Giant cauliflowers, yum!",
  Cauliflower2 = "Wow, this cauliflower is bigger than you are!",
  RepairSign = "Repair Shop",
  GlassSign = "Glassworking Studio",
  WoodworkingSign = "Woodworking Studio",
  MuseumSign = "Museum of History and Political Economy",
  DormitorySign = "Dormitory",
  LibrarySign = "Library",
  ScienceSign = "Research Lab",
  GatheringSign = "Gathering Hall",
  StationSign = "Hovertrain Station",
  RainbowArt = "\'Rainbow\' by The Stone Collectors\' Club",
  GenderArt = "\'Gender\' by The History Collective"}
