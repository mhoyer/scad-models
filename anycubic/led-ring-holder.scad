$fn = 100;
epsilon = 0.05;
infinite = 500;

wall_thickness = 1.6;
hole_d = 3.5;

he_length = 100;
he_width = 64.3;
he_height = 100;

ring_outer_d = 86;
ring_inner_d = 72;
ring_spacer = 8;

difference() {
    union() {
        translate([-wall_thickness/1.33,         23.2, wall_thickness/2+2*epsilon]) cube(size=[1.5*wall_thickness, 10, ring_spacer+13], center=true);
        translate([he_width+wall_thickness/1.33, 29.8, wall_thickness/2+2*epsilon]) cube(size=[1.5*wall_thickness, 10, ring_spacer+13], center=true);
        translate([he_width+wall_thickness/1.33, 62.1, wall_thickness/2+2*epsilon]) cube(size=[1.5*wall_thickness, 10, ring_spacer+13], center=true);

        translate([he_width/2, ring_outer_d/2, -ring_spacer-3*wall_thickness])
        difference() {
            union() {
                // cylinder(d=ring_inner_d+5*wall_thickness, h=4*wall_thickness);
                cylinder(d=ring_outer_d+2*wall_thickness, h=3*wall_thickness);
            }

            difference() {
                translate([0, 0, -epsilon]) cylinder(d=(ring_outer_d + ring_inner_d + wall_thickness)/2, h=2*wall_thickness);
                translate([0, 0, -2*epsilon]) cylinder(d=ring_inner_d-wall_thickness/1.5, h=infinite);
            }

            difference() {
                translate([0, 0, -epsilon]) cylinder(d=ring_outer_d+wall_thickness/2, h=2*wall_thickness);
                translate([0, 0, -2*epsilon]) cylinder(d=(ring_outer_d + ring_inner_d + wall_thickness)/2+wall_thickness/3, h=infinite);
            }
            translate([0, 0, -infinite/2]) cylinder(d=ring_inner_d-wall_thickness, h=infinite);
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
