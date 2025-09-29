local sound_dir = function(preset)
  local is_linux = require("utils.os").is_linux
  if is_linux() then
    return "/home/georgi.chochev/.config/nvim/sounds/" .. preset
  end

  return "/Users/exrun/.config/nvim/sounds/" .. preset
end

local sound_map = function(preset)
  if preset == "d2r" then
    return {
      { trigger_name = "teleport", sound = "teleport.wav" },
      { trigger_name = "enchant", sound = "enchant.wav" },
      { trigger_name = "summon", sound = "summon.wav" },
      { trigger_name = "fanaticism", sound = "fanaticism.wav" },
      { trigger_name = "redemption", sound = "redemption.wav" },
      { trigger_name = "amulet", sound = "amulet.wav" },
      { trigger_name = "belt", sound = "belt.wav" },
      { trigger_name = "button", sound = "button.wav" },
      { trigger_name = "levelup", sound = "levelup.wav" },
      { trigger_name = "windowopen", sound = "windowopen.wav" },
      { trigger_name = "rakanishu", sound = "rakanishu.wav" },
      { trigger_name = "weaken", sound = "weaken.wav" },
      { trigger_name = "potiondrink", sound = "potiondrink.wav" },
      { trigger_name = "potionui", sound = "potionui.wav" },
      { trigger_name = "cube", sound = "cube.wav" },

      { auto_command = "VimEnter", sound = "portalenter.wav" },
      { auto_command = "VimLeave", sound = "select.wav" },

      { auto_command = "BufAdd", sound = "blessedaim.wav" },
      { auto_command = "BufWrite", sound = "select.wav" },
      {
        auto_command = "BufDelete",
        sounds = {
          "corpse explode 1.wav",
          "corpse explode 2.wav",
          "corpse explode 3.wav",
          "corpse explode 4.wav",
          "corpse explode 5.wav",
          "corpse explode 6.wav",
        },
      },
      -- Doesnt work with autopairs (mini.pair) due their remap of the <BS>
      -- {
      --   key_map = { mode = "i", key_chord = "<BS>" },
      --   sounds = {
      --     "death1.wav",
      --     "death2.wav",
      --     "death3.wav",
      --     "death4.wav",
      --     "death5.wav",
      --     "death6.wav",
      --     "death7.wav",
      --     "rakanishu.wav",
      --   },
      -- },
      { auto_command = "TextYankPost", sound = "rune.wav" },
      -- {
      --   auto_command = "InsertCharPre",
      --   sounds = { "gethit1.wav", "gethit2.wav", "gethit3.wav", "gethit4.wav", "gethit5.wav" },
      -- },
    }
  end

  if preset == "minecraft" then
    return {
      { key_map = { mode = "i", key_chord = "<BS>" }, sounds = { "eat1.wav", "eat2.wav", "eat3.wav" } },

      { auto_command = "VimEnter", sound = "chestopen.oga" },
      { auto_command = "VimLeave", sound = "chestclosed.oga" },

      { auto_command = "InsertCharPre", sounds = { "stone1.oga", "stone2.oga", "stone3.oga", "stone4.oga" } },
      { auto_command = "TextYankPost", sounds = { "hit1.oga", "hit2.oga", "hit3.oga" } },

      { auto_command = "BufAdd", sound = "successful_hit.wav" },
      { auto_command = "BufDelete", sounds = { "explode1.wav", "explode2.wav", "explode3.wav" } },
      { auto_command = "BufWrite", sounds = { "open_flip1.oga", "open_flip2.oga", "open_flip3.oga" } },
    }
  end
end

return {
  "EggbertFluffle/beepboop.nvim",
  enabled = require("utils.os").is_linux() and false,
  -- dir = "~/dev/beepboop.nvim",
  event = "VimEnter",
  opts = {
    audio_player = require("utils.os").is_linux() and "pw-play",
    max_sounds = 20,
    volume = 100,
    sound_directory = sound_dir("d2r"),
    sound_map = sound_map("d2r"),
  },
}
