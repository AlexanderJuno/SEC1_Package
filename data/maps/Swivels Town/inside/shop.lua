-- Lua script of map Swivels Town/inside/shop.


local map = ...
local game = map:get_game()
local shop_welcome = false -- initialisation de la variable de la boutique
local tunic_obtained = game:get_value("chest_004_opened")
local tunic2_shop = map:get_entity("tunic2_shop")


-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()

  -- You can initialize the movement and sprites of various
  -- map entities here.
	if tunic_obtained ~= nil then
		tunic2_shop:set_enabled(true)
	else
		tunic2_shop:set_enabled(false)
	end
end

function shop_sensor:on_activated()
	-- permet de ne pas répéter le dialogue tant qu'on reste dans la boutique
	if shop_welcome == false then
		game:start_dialog("npc.shop_welcome")
		shop_welcome = true 
	end
end

function tunic2_shop:on_buying()
	local tunic_lvl = game:get_ability("tunic",variant)
	if tunic_lvl == 2 then
		game:start_dialog("shop.can't_buy")
		return false
	else
		return true
	end
end



-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end
