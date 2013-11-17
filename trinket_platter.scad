// Main body:
THICKNESS = 3;
WIGGLE_ROOM = 1;
WIDTH_X = 25 /* width of Trinket */;
WIDTH_Y = 31 /* length of Trinket */ + 16 /* length of power jack */ + WIGGLE_ROOM + THICKNESS;

// Back panel with power jack
HEIGHT = 18 + THICKNESS;
CORNER_RADIUS = 5;

DETAIL = 30;

module base()
{
    union()
    {
        // base
        cube(size = [WIDTH_Y, WIDTH_X, THICKNESS]);
        translate(v = [WIDTH_Y, WIDTH_X / 2, 0])
            cylinder(r = WIDTH_X / 2, h = THICKNESS, $fn = DETAIL);
        // back
        cube(size = [THICKNESS, WIDTH_X, HEIGHT]);
        // strain-relief corner
        translate(v = [THICKNESS - 0.1, 0, THICKNESS - 0.1])
            difference()
            {
                cube(size = [CORNER_RADIUS, WIDTH_X, CORNER_RADIUS]);
                translate(v = [CORNER_RADIUS, WIDTH_X + 1, CORNER_RADIUS])
                    rotate(a = [90, 0, 0])
                        cylinder(r = CORNER_RADIUS, h = WIDTH_X + 2, $fn = DETAIL);
            }
        translate(v = [THICKNESS - 0.1, THICKNESS - 0.1, THICKNESS - 0.1])
            rotate(a = [90, 0, 0])
                intersection()
                {
                    cylinder(r = 5, h = THICKNESS, $fn = DETAIL);
                    translate(v = [0, 0, -1])
                        cube(size = [5, 5, THICKNESS + 2]);
                }
        translate(v = [THICKNESS - 0.1, WIDTH_X - 0.1, THICKNESS - 0.1])
            rotate(a = [90, 0, 0])
                intersection()
                {
                    cylinder(r = 5, h = THICKNESS, $fn = DETAIL);
                    translate(v = [0, 0, -1])
                        cube(size = [5, 5, THICKNESS + 2]);
                }
    }
}

module trinket_holes()
{
    translate(v = [-10.675, 5.55, -1])
        cylinder(h = HEIGHT, r = 1.2, $fn = DETAIL);
    translate(v = [-10.675, -5.55, -1])
        cylinder(h = HEIGHT, r = 1.2, $fn = DETAIL);
    translate(v = [10.675, 5.55, -1])
        cylinder(h = HEIGHT, r = 1.2, $fn = DETAIL);
    translate(v = [10.675, -5.55, -1])
        cylinder(h = HEIGHT, r = 1.2, $fn = DETAIL);
}

difference()
{
    base();
    translate(v = [WIDTH_Y / 2 + THICKNESS + WIGGLE_ROOM + 4, WIDTH_X / 2, -1])
        trinket_holes();
    // hole for power jack
    translate(v = [-1, WIDTH_X / 2, HEIGHT - 4 - 2])
        rotate(a = [0, 90, 0])
            cylinder(r = 4, h = THICKNESS + 2, $fn = DETAIL);
    // hole for securing wires
    translate(v = [WIDTH_Y + 4, WIDTH_X / 2, -1])
        scale(v = [1, 1.5, 1])
        cylinder(r = 4.1, h = THICKNESS + 2, $fn = DETAIL);
}
