-- Lua script of map Swivels Town/inside/witch.
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

function witch:on_interaction()
	game:start_dialog("npc.witch",function(answer)
		if answer == 1 then
		-- confirm your choice
		game:start_dialog("npc.witch_confirmation", function(a)
			if a == 1 then
				-- yes i do
				game:set_ability("tunic", 4)
				game:set_ability("swim",1)
			elseif a == 2 then
				-- huh no
				sol.audio.play_sound("timer")
				end
		  end)
		elseif answer == 2 then
			sol.audio.play_sound("timer")
		end
	end)
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
