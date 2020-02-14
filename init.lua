

local colors = {
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
    ['light_blue:dye'] = 15 -- reserved for future use
}

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
            local color = colors[name] or false
            if color ~= false then
                local node = minetest.get_node(pos)
                node.param2 = color
                minetest.set_node(pos, node)
            end
        end
    end
    minetest.register_node(name, def)
end
