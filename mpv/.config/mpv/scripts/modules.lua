local mpv_scripts_dir_path = os.getenv("HOME") ..  "/.config/mpv/scripts/"
function load(relative_path) dofile(mpv_scripts_dir_path .. relative_path) end
load("mpv-youtube-quality/youtube-quality.lua")
load("mpv_sponsorblock_minimal/sponsorblock_minimal.lua")
