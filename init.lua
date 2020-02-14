

local colorapi_dye_lookup = {
-- The numbers here MUST match the colorapi_palette image's order.
    ['dye:white']      = 0,
    ['dye:grey']       = 1,  -- spelled "grey" upstream in dyes
    ['dye:dark_grey']  = 2,  -- spelled "grey" upstream in dyes
    ['dye:black']      = 3,
    ['dye:violet']     = 4,
    ['dye:blue']       = 5,
    ['dye:cyan']       = 6,
    ['dye:dark_green'] = 7,
    ['dye:green']      = 8,
    ['dye:yellow']     = 9,
    ['dye:brown']      = 10,
    ['dye:orange']     = 11,
    ['dye:red']        = 12,
    ['dye:magenta']    = 13,
    ['dye:pink']       = 14,

}
local colorapi_colors = {'white', 'grey', 'dark_grey', 'black', 'violet', 'blue', 'cyan', 'dark_green', 'green', 'yellow', 'brown', 'orange', 'red', 'magenta', 'pink'}
local colorapi_dyes = {'dye:white', 'dye:grey', 'dye:dark_grey', 'dye:black', 'dye:violet', 'dye:blue', 'dye:cyan', 'dye:dark_green', 'dye:green', 'dye:yellow', 'dye:brown', 'dye:orange', 'dye:red', 'dye:magenta', 'dye:pink'}
if (rawget(_G, "lightblue")) then  -- TODO: make a light_blue mod
    colorapi_colors[16] = "lightblue"
    -- Minetest palette indices start at 0, so 15 is last (same as 16th Lua index):
    colorapi_dye_lookup['light_blue:dye'] = 15
end
function colorapi.register_colorapi_node(name, def)
-- special thanks: Linuxdirk on minetest forum f=47&t=19492
    def.paramtype2 = 'color'
    def.drawtype = 'color'
    def.palette = 'colorapi_palette.png', -- 16x16?, 1 color per pixel
    def.on_place = function(placer)
        local meta = placer:get_wielded_item():get_meta()
        -- TODO: Use the item metadata
        print("WARNING: colorapi place using metadata is not yet implemented.")
    end
    def.on_punch = function(pos, node, puncher, pointed_thing)
        local meta = puncher:get_wielded_item():get_meta()
        -- TODO: Use the item metadata
        if minetest.registered_items[name].groups.dye ~= nil then
            local color = colorapi_dye_lookup[name] or false
            if color ~= false then
                local node = minetest.get_node(pos)
                node.param2 = color
                minetest.set_node(pos, node)
            end
        end
    end
    minetest.register_node(name, def)
    for index, this_dye_name in ipairs(colorapi_dyes) do
        minetest.register_craft({
            type = "shapeless",
            output = "colorapi:wool",
            recipe = {"colorapi:wool", this_dye_name},
        })
        minetest.register_on_craft(
            function(itemstack, player, old_craft_grid, craft_inv) {
                -- TODO: check ingredients and set param2
            }
        )
    end
end


