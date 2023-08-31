-- Lua script of map Swivels Town/inside/Ale.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()
local hero = map:get_hero()

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()

  -- You can initialize the movement and sprites of various
  -- map entities here.
end

function bartender:on_interaction()
	game:start_dialog("npc.bartender", function (answer)
		if answer == 1 then
		-- buy a beer
			sol.audio.play_sound("timer")
				local money = game:get_money()
				if money >= 15 then
					local hero_life = game:get_life()
					if hero_life <= 4 then 
						game:start_dialog("npc.bartender_you're_drunk")
					elseif hero_life > 4 then 
						game:remove_money(15)
						sol.audio.play_sound("walk_on_water")
						game:remove_life(2)
					end
				else game:start_dialog("_shop.not_enough_money")
				end
		elseif answer == 2 then
			-- Continue
			sol.audio.play_sound("ok")
		end
	end)
end

function sensor_bar:on_activated()
		game:start_dialog("npc.bartender", function (answer)
		if answer == 1 then
		-- buy a beer
			sol.audio.play_sound("timer")
				local money = game:get_money()
				if money >= 15 then
					local hero_life = game:get_life()
					if hero_life <= 4 then 
						game:start_dialog("npc.bartender_you're_drunk")
					elseif hero_life > 4 then 
						game:remove_money(15)
						sol.audio.play_sound("walk_on_water")
						game:remove_life(2)
					end
				else game:start_dialog("_shop.not_enough_money")
				end
		elseif answer == 2 then
			-- Continue
			sol.audio.play_sound("ok")
		end
	end)
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
