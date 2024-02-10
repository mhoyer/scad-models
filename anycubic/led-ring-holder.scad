$fn = 100;
epsilon = 0.05;
infinite = 500;

wall_thickness = 1.6;
hole_d = 3.4;

he_length = 100;
he_width = 64.3;
he_height = 100;

ring_outer_d = 86;
ring_inner_d = 72;
ring_spacer = 3.6;
ring_height = 3*wall_thickness;

cut_out_w = 11;

difference() {
    union() {
        // hotend connectors
        translate([-wall_thickness/2, 23.2,          (8 - ring_spacer - wall_thickness)/2])
        cube(size=[wall_thickness, 10,                8 + ring_spacer + wall_thickness], center=true);

        translate([he_width+wall_thickness/2, 29.8, (11 - ring_spacer - wall_thickness)/2])
        cube(size=[wall_thickness, 10,                11 + ring_spacer + wall_thickness], center=true);

        translate([he_width+wall_thickness/2, 62.1,  (11 - ring_spacer - wall_thickness)/2])
        cube(size=[wall_thickness, 10,                11 + ring_spacer + wall_thickness], center=true);

        // the ring
        translate([he_width/2, ring_outer_d/2, -ring_height-ring_spacer])
        difference() {
            union() {
                cylinder(d=ring_outer_d+2*wall_thickness, h=ring_height);
            }

            // mid layer exclude
            translate([0, 0, wall_thickness/2-epsilon])
            cylinder(d=ring_outer_d, h=1.5*wall_thickness);

            // bottom layer exclude
            translate([0, 0, -wall_thickness-epsilon])
            cylinder(d=ring_outer_d, h=3*wall_thickness);

            // large center hole
            translate([0, 0, -infinite/2]) cylinder(d=ring_inner_d-wall_thickness, h=infinite);

            // cut out
            translate([0, ring_outer_d-3*wall_thickness, 0])
            cube(size=[cut_out_w, ring_outer_d, infinite], center=true);
        }

        // three bottom ring clips

        translate([he_width/2, ring_outer_d/2, -ring_height-ring_spacer])
        rotate([0,0,78])
        union() {
            translate([ring_outer_d/2-wall_thickness/2, 0, 0])
            cube(size=[wall_thickness, 2*wall_thickness, wall_thickness/2]);

            rotate([0,0,20])
            translate([ring_outer_d/2-wall_thickness/2, 0, 0])
            cube(size=[wall_thickness, 2*wall_thickness, wall_thickness/2]);

            rotate([0,0,140])
            translate([ring_outer_d/2-wall_thickness/3, 0, 0])
            cube(size=[wall_thickness, 2*wall_thickness, wall_thickness/2]);

            rotate([0,0,240])
            translate([ring_outer_d/2-wall_thickness/3, 0, 0])
            cube(size=[wall_thickness, 2*wall_thickness, wall_thickness/2]);
        }
    }

    // hotend body with screw holes (as neg. mask)
    union() {
        translate([epsilon/2,0,0])
        cube(size=[he_width-epsilon, he_length, he_height]);

        translate([0, 23.2, 3.5]) rotate([0, 90, 0])
        cylinder(d=hole_d, h=30, center=true);

        translate([he_width, 29.8, 6.85]) rotate([0, 90, 0])
        cylinder(d=hole_d, h=30, center=true);
        translate([he_width, 62.1, 6.85]) rotate([0, 90, 0])
        cylinder(d=hole_d, h=30, center=true);
    }
}

// color("#f00a")
// translate([he_width/2, ring_outer_d/2, -ring_spacer-4*wall_thickness])
// difference() {
//     union() {
//         cylinder(d=ring_outer_d, h=1);
//     }
//     translate([0, 0, -infinite/2]) cylinder(d=ring_inner_d, h=infinite);
// }
