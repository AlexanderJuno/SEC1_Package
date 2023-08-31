-- Lua script of enemy poulet.
-- This script is executed every time an enemy with this model is created.

local enemy = ...
local map = enemy:get_map()

local angry = false
local num_times_hurt = 0

function enemy:on_created()

  enemy:set_life(5)
  enemy:set_damage(8)
  enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_size(16, 16)
  enemy:set_origin(8, 13)
  enemy:set_hurt_style("normal")
end

function enemy:on_movement_changed(movement)

  local direction4 = movement:get_direction4()
  local sprite = self:get_sprite()
  sprite:set_direction(direction4)
end

function enemy:on_obstacle_reached(movement)

  if not angry then
		enemy:go_random()
		enemy:picking()
  else
    enemy:go_angry()
  end
end

function enemy:on_restarted()

  if angry then
    enemy:go_angry()
  else
    enemy:go_random()
    sol.timer.start(enemy, 100, function()
      if map.angry_chickens and not angry then
        enemy:go_angry()
        return false
      end
      return true  -- Repeat the timer.
    end)
  end
end


function enemy:go_random()

  angry = false
  local movement = sol.movement.create("random")
  movement:set_speed(32)
  movement:start(enemy)
  enemy:set_can_attack(false)
	sol.timer.start(self, 1000, function()
      self:picking()
  end)
	
end

-- On veut que le poulet picore le sol de temps en temps
function enemy:picking()
  -- stop for a while
	angry = false
	local sprite = self:get_sprite()
  local animation = sprite:get_animation()
  if animation == "walking" then
		-- on arrête le poulet pour qu'il ne picore pas et bouge en même temps
		local movement = self:get_movement() 
		movement:stop(self)
    sprite:set_animation("picking")
    sol.timer.start(enemy, 1000, function()
      enemy:go_random(math.random(4)-1)
    end)
  end
	sol.timer.start(self, 500, function()
      self:restart()
  end)
end

-- On veut que le poulet attaque le joueur s'il a été attaqué
function enemy:go_angry()

  angry = true
  map.angry_chickens = true
  going_hero = true
  local movement = sol.movement.create("target")
  movement:set_speed(96)
  movement:start(enemy)
  enemy:get_sprite():set_animation("angry")
  enemy:set_can_attack(true)
end

function enemy:on_hurt()
	sol.audio.play_sound("poulet_hurt")
  num_times_hurt = num_times_hurt + 1
  if num_times_hurt == 3 and not map.angry_chickens then
    -- Make all chickens of the map attack the hero.
    map.angry_chickens = true
  end
end

function enemy:on_dead()
	random = math.random(100)
  if random < 30 then
    local map = enemy:get_map()
    local x, y, layer = enemy:get_position()
    map:create_pickable{
     layer = layer,
     x = x,
     y = y,
     treasure_name = "chicken_wings",
     }
	elseif random > 70 then
    local map = enemy:get_map()
    local x, y, layer = enemy:get_position()
    map:create_pickable{
     layer = layer,
     x = x,
     y = y,
     treasure_name = "gem",
		 treasure_variant = math.random(2),-- permet d'avoir le variant 1 ou 2 pour le money_drop
     }
	end
end
