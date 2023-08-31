-- Lua script of map Swivels Town/inside/smith.
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

function blacksmith:on_interaction()
	local sword_level = game:get_ability("sword")
	game:start_dialog("npc.blacksmith", function (answer)
		if answer == 1 then
		-- upgrade the sword level
			sol.audio.play_sound("ok")
			if sword_level == 1 then
				local money = game:get_money()
				if money >= 275 then
					game:remove_money(275)
					game:set_ability("sword",2)
				else game:start_dialog("_shop.not_enough_money")
				end
			elseif sword_level == 2 then
				local money = game:get_money()
				if money >= 575 then
					game:remove_money(575)
					game:set_ability("sword",3)
				else game:start_dialog("_shop.not_enough_money")
				end
			elseif sword_level == 3 then
				local money = game:get_money()
				if money >= 775 then
					game:remove_money(775)
					game:set_ability("sword",4)
				else game:start_dialog("_shop.not_enough_money")
				end
			elseif sword_level == 4 then
				game:start_dialog("npc.blacksmith_cannot_upgrade")
			end
		elseif answer == 2 then
			-- Continue
			sol.audio.play_sound("timer")
		end
	end)
end


-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
