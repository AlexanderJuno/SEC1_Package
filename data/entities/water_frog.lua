-- Lua script of custom entity water_frog.
-- This script is executed every time a custom entity with this model is created.


local entity = ...
local game = entity:get_game()
local map = entity:get_map()


-- Event called when the custom entity is initialized.
function entity:on_created()

  entity:set_traversable_by("hero", true)
	entity:set_traversable_by("enemy", true)
	entity:set_can_traverse_ground("shallow_water",true)
	entity:set_can_traverse_ground("traversable", false)
	entity:set_size(16, 24)
	-- choose the sprite "green frog" in the box menu of the custom entity
	-- local sprite = entity:get_model("animal/water_frog")
	entity:jumping()
	entity:waiting()
end

function entity:on_movement_changed(movement)

  local direction4 = movement:get_direction4()
  local sprite = entity:get_sprite()
  sprite:set_direction(direction4)

end

function entity:jumping()
	
	local sprite = entity:get_sprite()
  local animation = sprite:get_animation()
  if animation == "waiting" then
		sprite:set_animation("jumping")
		
  	local movement = sol.movement.create("random")
  	movement:set_speed(24)
  	movement:start(entity)
		sol.timer.start(entity, 500, function()
      entity:waiting()
  	end)
	else
		sol.audio.play_sound("walk_on_water")
		local movement = sol.movement.create("random")
  	movement:set_speed(24)
  	movement:start(entity)
		sol.timer.start(entity, 500, function()
      entity:waiting()
  	end)
	end
end

function entity:waiting()
	local sprite = entity:get_sprite()
  local animation = sprite:get_animation()
  if animation == "jumping" then
		-- on arrête la grenouille pour qu'elle attende
		local movement = entity:get_movement() 
		movement:stop(entity)
    sprite:set_animation("waiting")
    sol.timer.start(entity, 900, function()
      entity:jumping(math.random(4)-1)
    end)
  end
	sol.timer.start(entity, 900, function()
      entity:jumping()
  end)
end

