-- Lua script of map yakuf_plains_NE.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()

  -- You can initialize the movement and sprites of various
  -- map entities here.
end

function sensor_layer_up:on_activated()
	-- hero:get_layer()
	hero:set_layer(1)
	
end

function sensor_layer_down:on_activated()
	-- hero:get_layer()
	hero:set_layer(0)

end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
