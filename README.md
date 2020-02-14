# colorapi
This is a WIP mod for unifying colors for Minetest into a beautiful palette that will connect artists with "the land" (dyes and their sources), instead of just making more and more like unifieddyes does. Part of the aim is to recolor existing nodes to match a beautiful 16-color palette.


## Tasks
- [ ] reorder the palette so the first 8 are compatible with colorfacedir (8-color palette) and the next 8 are lighter or similar light versions of those 8 in order.


## morecolorfacedir
colorfacedir only provides 8 colors. A new drawtype would be nice:  4 bits are texture. next 2 bits are index of `float rotations[4] = [0, .5f*M_PI, M_PI, 1.5*M_PI];`. The last 2 bits are axis of rotation (the value being 0, 1 or 2 means x y or z (the value 3 is invalid))
