-- Lua script of map Swivels Town/inside/Inn.


local map = ...
local game = map:get_game()

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()

  -- You can initialize the movement and sprites of various
  -- map entities here.
end

function inn_owner:on_interaction()
	game:start_dialog("npc.inn", function (answer)
		if answer == 1 then
			-- Save and continue.
			sol.audio.play_sound("ok")
			game:save()
		elseif answer == 2 then
			-- Continue
			sol.audio.play_sound("timer")
		end
	end)
end

function sensor_inn_owner:on_activated()
	game:start_dialog("npc.inn", function (answer)
		if answer == 1 then
			-- Save and continue.
			sol.audio.play_sound("ok")
			game:save()
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
