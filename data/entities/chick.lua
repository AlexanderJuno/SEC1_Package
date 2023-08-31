-- Lua script of custom entity chick.
-- This script is executed every time a custom entity with this model is created.


local entity = ...
local game = entity:get_game()
local map = entity:get_map()
require("scripts/multi_events")

-- Event called when the custom entity is initialized.
function entity:on_created()
	
	
	entity:set_traversable_by("hero", false)
	entity:set_traversable_by("enemy", false)
	entity:set_weight(0)
	entity:set_size(16, 16)
	-- choose the sprite "chick" in the box menu of the custom entity
	entity:go_random()
  sol.timer.start(entity, 1000, function() entity:picking() end)
 
end

function entity:on_movement_changed(movement)

  local direction4 = movement:get_direction4()
  local sprite = entity:get_sprite()
  sprite:set_direction(direction4)

end


function entity:go_random()
	-- On veut que l'animation change pour celle de walking après que la poule ait picoré
	local sprite = entity:get_sprite()
  local animation = sprite:get_animation()
  if animation == "picking" then
		sprite:set_animation("walking")
  	local movement = sol.movement.create("random")
  	movement:set_speed(24)
  	movement:start(entity)
		sol.timer.start(entity, 1000, function()
      entity:picking()
  	end)
	else
		local movement = sol.movement.create("random")
  	movement:set_speed(24)
  	movement:start(entity)
		sol.timer.start(entity, 1000, function()
      entity:picking()
  	end)
	end
	
end

-- On veut que la poule picore le sol de temps en temps
function entity:picking()
	
	local sprite = entity:get_sprite()
  local animation = sprite:get_animation()
  if animation == "walking" then
		-- on arrête la poule pour qu'elle ne picore pas et bouge en même temps
		local movement = entity:get_movement() 
		movement:stop(entity)
    sprite:set_animation("picking")
    sol.timer.start(entity, 1000, function()
      entity:go_random(math.random(4)-1)
    end)
  end
	sol.timer.start(entity, 500, function()
      entity:go_random()
  end)
end

function entity:on_lifting(carrier, carried_object)
	sol.audio.play_sound("bird_chirp2")
  carried_object:set_destruction_sound("bird_chirp")


  --landing, and therefore needing to create a new chick
  function carried_object:on_breaking()
    local x, y, layer = carried_object:get_position()
    local width, height = carried_object:get_size()
    local sprite = carried_object:get_sprite()
    local direction = sprite:get_direction()

    if carried_object:get_ground_below() == "wall" then y = y + 16 end
    carried_object:get_map():create_custom_entity({
      width = width, height = height, x = x, y = y, layer = layer,
      direction = direction, model = "chick", sprite = sprite:get_animation_set()
    })
  end

end

