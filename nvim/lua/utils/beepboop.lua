local M = {}

function M.play_audio(sound)
  local ok, module = pcall(require, "beepboop")
  if ok then
    return module.play_audio(sound)
  end
end

return M
