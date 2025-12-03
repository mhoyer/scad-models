$fn=80;
infinity = 100;
thickness = 2;

pcb_w = 33.4;
pcb_l = 33.7;
pcb_t = 1.0;
module pcb() {
    hull() {
        translate([-pcb_w/2+3, -pcb_l/2+3, 0])
        cylinder(r=3, h=pcb_t);
        translate([-pcb_w/2+3,  pcb_l/2-3, 0])
        cylinder(r=3, h=pcb_t);
        translate([ pcb_w/2-3,  pcb_l/2-3, 0])
        cylinder(r=3, h=pcb_t);
        translate([ pcb_w/2-3, -pcb_l/2+3, 0])
        cylinder(r=3, h=pcb_t);
    }
}

aaa_bat_d = 10.3;
aaa_bat_h = 44.2;
module two_aaa_bat() {
    module aaa_bat() {
        union() {
            cylinder(r=aaa_bat_d/2, h=42.8);
            translate([0, 0, 0.0001])
            cylinder(r=2, h=aaa_bat_h);
        }
    }

    union() {
        rotate([-90, 0, 0])
        translate([-aaa_bat_d/2-0.1,0,0])
        aaa_bat();

        rotate([90, 0, 0])
        translate([ aaa_bat_d/2+0.1,0,-aaa_bat_h])
        aaa_bat();
    }
}

switch_block_w = 42.3;
switch_block_l = 31.75;
switch_block_h = 16;
module switch() {
    difference() {
        cube(size=[switch_block_w, switch_block_l, switch_block_h], center=true);

        translate([0, 0, (infinity+16)/2 - 3])
        cube(size=[17.5, infinity, infinity], center=true);

        translate([0, 0, (infinity+16)/2 - 3])
        cube(size=[21.4, 16, infinity], center=true);

        translate([0, 8, (infinity+16)/2 - 3])
        cube(size=[infinity, 4, infinity], center=true);
        translate([0, -8, (infinity+16)/2 - 3])
        cube(size=[infinity, 4, infinity], center=true);
    }
}

diff = 2;
case_w = 2 * (aaa_bat_d + thickness); // = 24.6
case_l = aaa_bat_h+8; // = 52.2
case_h = aaa_bat_d-0.8; // = 9.5

module case() {
    union() {
        difference() {
            translate([0, 0, aaa_bat_d/2+1.4])
            hull() {
                cube(size=[case_w, case_l, case_h], center=true);
                cube(size=[pcb_w+thickness, pcb_l+thickness, case_h], center=true);
            }

            translate([0, 0, aaa_bat_d/2])
            hull() {
                cube(size=[pcb_w, pcb_l, aaa_bat_d], center=true);
                cube(size=[pcb_w-thickness, aaa_bat_h-7, aaa_bat_d], center=true);
            }

            hull() {
                cube(size=[pcb_w, pcb_l-12, infinity], center=true);
                cube(size=[2*aaa_bat_d-thickness, aaa_bat_h-7, infinity], center=true);
            }
            translate([0, 0, aaa_bat_d/2])
            cube(size=[pcb_w, pcb_l, aaa_bat_d], center=true);

            hull() {
                cube(size=[2*aaa_bat_d+0.5, aaa_bat_h+0.2, aaa_bat_d], center=true);

                translate([aaa_bat_d/2+0.25, 0, aaa_bat_d/2])
                rotate([-90, 0, 0])
                cylinder(r=aaa_bat_d/2, h=aaa_bat_h+0.6, center=true);

                translate([-aaa_bat_d/2-0.25, 0, aaa_bat_d/2])
                rotate([-90, 0, 0])
                cylinder(r=aaa_bat_d/2, h=aaa_bat_h+0.6, center=true);
            }
            // rail cut out
            translate([0, 0, 3])
            cube(size=[infinity, 12.5, 4.5], center=true);

            translate([0, 0, aaa_bat_d/2])
            cube(size=[2*aaa_bat_d+0.5, aaa_bat_h-7, aaa_bat_d], center=true);

            hull() {
                translate([0,-5,0])
                cylinder(d=2*aaa_bat_d, h=infinity, center=true);
                translate([0,-2,0])
                cylinder(d=2*aaa_bat_d, h=infinity, center=true);
            }

            // holes
            union() {
                // holes for wires
                translate([aaa_bat_d/2, aaa_bat_h/2+2.3])
                cylinder(r=.7, h=infinity, center=true);
                translate([-aaa_bat_d/2, aaa_bat_h/2+2.3])
                cylinder(r=.7, h=infinity, center=true);
                translate([aaa_bat_d/2, aaa_bat_h/2+0.1])
                cylinder(r=.6, h=infinity, center=true);
                translate([-aaa_bat_d/2, aaa_bat_h/2+0.1])
                cylinder(r=.6, h=infinity, center=true);

                translate([aaa_bat_d/2, -aaa_bat_h/2-2.3])
                cylinder(r=.7, h=infinity, center=true);
                translate([-aaa_bat_d/2, -aaa_bat_h/2-2.3])
                cylinder(r=.7, h=infinity, center=true);
                translate([aaa_bat_d/2, -aaa_bat_h/2-0.1])
                cylinder(r=.6, h=infinity, center=true);
                translate([-aaa_bat_d/2, -aaa_bat_h/2-0.1])
                cylinder(r=.6, h=infinity, center=true);

                // pcb holes
                // m3_hole = 3.3;
                // translate([0, (pcb_l+m3_hole)/2])
                // cylinder(d=m3_hole, h=infinity, center=true);
                // translate([0, -(pcb_l+m3_hole)/2])
                // cylinder(d=m3_hole, h=infinity, center=true);

                // mount holes
                translate([2, 10])
                cylinder(d=2, h=infinity, center=true);
                translate([-2, 10])
                cylinder(d=2, h=infinity, center=true);
            }

            translate([aaa_bat_d/2, 0, 0])
            cube(size=[1, infinity, 5], center=true);
            translate([-aaa_bat_d/2, 0, 0])
            cube(size=[1, infinity, 5], center=true);
        }
    }
}

case();
// translate([0, 0, 11.3]) clip();