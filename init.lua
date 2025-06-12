local S = minetest.get_translator("laser")

minetest.register_tool("laser:laser_miner", {
    description = "Laser Miner",
    inventory_image = "laser_miner.png",
    groups = {dig = 1, attack = 1},

    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing and pointed_thing.type == "node" then
            local target_pos = pointed_thing.under
            local node = minetest.get_node(target_pos)
            if node.name ~= "air" and not minetest.registered_nodes[node.name].groups.unbreakable then
				minetest.node_dig(target_pos, node, user)
				
				minetest.add_particlespawner({
					amount = 10,
					time = 0.05,
					minpos = target_pos,
					maxpos = vector.add(target_pos, {x=0.5, y=0.5, z=0.5}),
					minvel = {x=-3, y=-3, z=-3},
					maxvel = {x=3, y=5, z=3},
					minacc = {x=0, y=-9.8, z=0},  -- gravité vers le bas
					maxacc = {x=0, y=-9.8, z=0},
					minexptime = 0.3,
					maxexptime = 0.5,
					minsize = 3,
					maxsize = 5,
					texture = "laser_flash.png",
					glow = 14,
				})
                -- Position des yeux
                local eye_pos = vector.add(user:get_pos(), {x=-0.25, y=1.25, z=0})
				--local center_of_block = vector.add(target_pos, {x = 0.5, y = 0.5, z = 0.5})
                local dir = vector.direction(eye_pos, target_pos)

                -- Particules : de l'œil vers le bloc
               minetest.add_particlespawner({
					amount = 20,
					time = 0.2,
					minpos = eye_pos,
					maxpos = eye_pos,
					minvel = vector.multiply(dir, 20),
					maxvel = vector.multiply(dir, 20),
					minacc = {x = 0, y = 0, z = 0},
					maxacc = {x = 0, y = 0, z = 0},
					minexptime = 0.2,
					maxexptime = 0.2,
					minsize = 1,
					maxsize = 1,
					texture = "laser_beam.png",
					glow = 10,
				})

                -- Usure
                -- itemstack:add_wear(1000) --DEBUG
            end
        end
        return itemstack
    end
})

minetest.register_node("laser:citronox", {
	description = S("Recharge citronox"),
	tiles = {
		"citronox_top.png^[transform2",
		"citronox_bottom.png",
		"citronox_side.png",
		"citronox_side.png",
		"citronox_rear.png",
		"citronox_front.png"
	},
	paramtype2 = "facedir",
	groups = {crunch = 1},
	})