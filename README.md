# colorapi
This is a WIP mod for unifying colors for Minetest into a beautiful palette that will connect artists with "the land" (dyes and their sources), instead of just making more and more like unifieddyes does. Part of the aim is to recolor existing nodes to match a beautiful 16-color palette.


## Tasks
- [ ] reorder the palette so the first 8 are compatible with colorfacedir (8-color palette) and the next 8 are lighter or similar light versions of those 8 in order.


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
