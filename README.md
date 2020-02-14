# colorapi

This is a WIP mod for unifying colors for Minetest into a beautiful palette that will connect artists with "the land" (dyes and their sources), instead of just making more and more like unifieddyes does. Part of the aim is to recolor existing nodes to match a beautiful 16-color palette.

https://github.com/poikilos/colorapi


## Other known palettes
(* = compatible with colorapi, ~ = compatible with colorapi at least temporarily)
Other known palettes just keep adding more and more colors (though optionally "only" 32 in unifieddyes), instead of considering choosing a palette to theme the world and provide a direction for mods. Other palettes are notable, however, to try to make this colorapi as compatible as possible with the param2 palette indices they use when they use `drawtype = "color"` and `paramtype2 = "color"`.
- unifieddyes/textures/unifieddyes_palette_extended.png
  - [ ] The plan for this is for colorapi is to reduce the set of colors for these nodes (through some sort of scripted down-conversion).
- unifieddyes/textures/unifieddyes_palette_colorfacedir.png
  - [ ] ~ The plan for this is for colorapi is to reduce the set of colors for these nodes (through some sort of scripted down-conversion), but in this case, for now
- unifieddyes/textures/unifieddyes_palette_*.png
  - unifieddyes "split" palettes in there which require multiple node registrations, since colorfacedir only allows 8 colors (so for example, in 32-color mode, unifieddyes would register 4 nodes for each material)--see `register_color_craft` in unifieddyes.
  - and various other "split" palettes in there
- Sokomine's morecolor mod transforms:
  - drawtype "normal" paramtype2 "none" or "wallmounted" into colorwallmounted (32-color; using unifieddyes_palette_colorwallmounted.png)
    - ~ colorapi's "colorapi_palette_compat_wallmounted.png" palette is compatible with the param2 indices from morecolor colorwallmounted nodes.
      - [ ] some sort of scripted down-conversion is desirable to retain a consistent theme in the game.
  - paramtype2 "facedir" into "colorfacedir" (8-color; using morecolor_facedir_8colors_palette.png, formerly colorfacedir_palette.png)
    - * colorapi_palette8 is compatible with indexes (param2) from Sokomine's morecolor (the compatibility only applies to its colorfacedir nodes, which facedir nodes become when using the morecolor mod; colorwallmounted).
      - some sort of scripted upconversion is desireable, but in the case of colorfacedir, that would require an additional node per material due to the 8-color limit.
    - available at https://raw.githubusercontent.com/Sokomine/morecolor/master/textures/morecolor_facedir_8colors_palette.png
- xconnected formerly used colorfacedir_palette.png, the old name for the morecolor palette, if `minetest.get_modpath("morecolor")` returns non-nil.
- darkage/textures/darkage_palette.png
  - a.k.a. ~/minetest/games/Bucket_Game/mods/coderbuild/darkage/textures/darkage_palette.png
  - colorapi ignores compatibility with this odd palette order. Maybe one day the mod can be converted to use the colorapi standard 16-color palette.
- stained_glass formerly used stained_glass_faint_palette.png and stained_glass_pastels_palette.png
  - The order is the same as darkage_palette.
  - VanessaE switched over to unifieddyes and deleted the two stained_glass palettes in https://github.com/minetest-mods/stained_glass/commit/fef736edd6ad1d76588dfb5282f06519d59d3f38
  - The two palettes are available at:
    - https://raw.githubusercontent.com/minetest-mods/stained_glass/94bbecfd3b530cf74f08f812706d3ed0eaaf3e0b/textures/stained_glass_faint_palette.png
    - https://raw.githubusercontent.com/minetest-mods/stained_glass/94bbecfd3b530cf74f08f812706d3ed0eaaf3e0b/textures/stained_glass_pastels_palette.png


## Tasks
- [ ] reorder the palette so the first 8 are compatible with the 8-color palette of notable existing mods if possible and the next 8 are lighter or similar light versions of those 8 in order.


## morecolorfacedir
colorfacedir only provides 8 colors. A new drawtype would be nice:  4 bits are texture. next 2 bits are index of `float rotations[4] = [0, .5f*M_PI, M_PI, 1.5*M_PI];`. The last 2 bits are axis of rotation (the value being 0, 1 or 2 means x y or z (the value 3 is invalid))

The code below isn't real, but it is similar to what could happen:
```C++
int palette_index = 0;
int texture_number = 0;
float angle = 0;
int axis = 0;
if (param_type_2 == CPT2_TEXTURED_FACEDIR) {
    palette_index = param2 >> 4;
    angle = (param2 >> 2) & 3;
    axis = param2 & 3;  // 0 is x, 1 is y, 2 is z, or whatever order other parts of the engine use.
}
/*
// colorfacedir is already implemented (has only 8 colors, but still, only 2 node registrations are necessary for 16 colors)
else if (paramtype2 == CPT2_16COLORED_FACEDIR) {
    texture_number = param2 >> 4;
    angle = (param2 >> 2) & 3;
    axis = param2 & 3;  // 0 is x, 1 is y, 2 is z, or whatever order other parts of the engine use.
}
*/

if (texture_number > 0) {
    // below assumes texture_name is the filename without the extension:
    texture_name += std:to_string(texture_number);
}
```
