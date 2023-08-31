-- Lua script of map first_map.
-- This script is executed every time the hero enters this map.

local map = ...
local game = map:get_game()
local tunic_chest = map:get_entity("tunic1_chest")
local tunic_lvl = game:get_ability("tunic", variant)

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()

  -- You can initialize the movement and sprites of various
  -- map entities here.
	if tunic_lvl ~= 4 then
		tunic_chest:set_enabled(false)
	end
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()
	if tunic_lvl ~= 4 then
		game:set_ability("swim",0)
	end
end
