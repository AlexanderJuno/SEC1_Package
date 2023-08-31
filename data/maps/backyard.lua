-- Lua script of map outside.


local map = ...
local game = map:get_game()

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()

  -- You can initialize the movement and sprites of various
  -- map entities here.
end

function delete_sign:on_interaction()
	game:start_dialog("delete_save", function (answer)
			if answer == 1 then
				game:start_dialog("confirmation",function (a)
					if a == 1 then
						-- delete savefile
						sol.audio.play_sound("timer")
						sol.game.delete("INF100_save.dat")
						print("deleting the file")
						sol.main.reset()
						
					elseif a == 2 then
						-- Continue
						sol.audio.play_sound("ok")
					end
				end)
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
