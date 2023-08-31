-- Lua script of custom entity sleeping_chicken.

local entity = ...
local game = entity:get_game()
local map = entity:get_map()

require("scripts/multi_events")

local sprite = entity:get_sprite()
local animation = sprite:get_animation()

-- Event called when the custom entity is initialized.
function entity:on_created()
	
	entity:set_traversable_by(false)
	entity:set_traversable_by("hero", false)
	entity:set_traversable_by("enemy", false)
	entity:set_drawn_in_y_order(false)
	entity:set_weight(0)
	entity:set_size(16, 16)
	
	-- choose the sprite "sleeping_chick" in the box menu of the custom entity
	
	entity:sleep()
  
 
end

function entity:on_movement_changed(movement)

  local direction4 = movement:get_direction4()
  local sprite = entity:get_sprite()
  sprite:set_direction(direction4)

end

function entity:sleep()
	local sprite = entity:get_sprite()
  local animation = sprite:get_animation()
	sprite:set_animation("asleep")
	local movement = sol.movement.create("pixel")
	movement:start(entity)

end

function entity:on_lifting(carrier, carried_object)
 	sol.audio.play_sound("bird_chirp2")
  carried_object:set_destruction_sound("bird_chirp")

  --landing, and therefore needing to create a new sleeping_chick
  function carried_object:on_breaking()
    local x, y, layer = carried_object:get_position()
    local width, height = carried_object:get_size()
    local sprite = carried_object:get_sprite()
    local direction = sprite:get_direction()

    if carried_object:get_ground_below() == "wall" then y = y + 16 end
    carried_object:get_map():create_custom_entity({
      width = width, height = height, x = x, y = y, layer = layer,
      direction = direction, model = "sleeping_chicken", sprite = sprite:get_animation_set()
    })
  end

end

