epsilon = 0.01;
nozzle_d = 0.4;
print = 0; // set to 0 or 1
$fn = 70;

wdt_stand();

module wdt_stand(){
    // main parameters
    needles = 10;
    needle_d = 1.5;
    needle_l = 75; // total length
    needle_grip_d = 2;
    needle_grip_l = 34;

    disc_d=12;
    disc_th=2;
    btm_off_z=0;
    mid_off_z=8;
    top_off_z=mid_off_z + needle_grip_l - disc_th - 10;
    height = top_off_z + disc_th + 2*epsilon;
    center_tube_d = 10*nozzle_d;

    difference() {
        union() {
            translate([0, 0, top_off_z+epsilon-disc_th])
            disc_with_holes(disc_d=8.5, circ_holes=needles-1, holes_d=needle_grip_d, holes_off_r=4, disc_th=2*disc_th);

            translate([0, 0, mid_off_z+epsilon])
            disc_with_holes(disc_d=10, circ_holes=needles-1, holes_d=needle_d, holes_off_r=4, disc_th=disc_th, hole_rot_b=-6);

            translate([0, 0, btm_off_z+epsilon])
            disc_with_holes(disc_d=disc_d, circ_holes=needles-1, holes_d=needle_d, holes_off_r=6.8, disc_th=disc_th, hole_rot_b=-15);

            // center tube
            translate([0,0,0]) cylinder(h=height, d=center_tube_d);
        }

        // center tube holes
        translate([0,0,mid_off_z+disc_th+1]) cylinder(h=needle_grip_l, d=needle_grip_d);
        translate([0,0,-1]) cylinder(h=2*height, d=needle_d);
        translate([0, 0, -15]) cube([30,30,30], center=true);
        // translate([0, 0, 50 + 3]) cube([30,30,100], center=true);
    }
}

module disc_with_holes(disc_d=10, holes_d=1, holes_off_r=3, disc_th=2, circ_holes=9, hole_rot_b=0) {
    holes_d = max(1, holes_d);
    difference(){
        // the disc
        union() {
            cylinder(h=disc_th, d=disc_d);
            translate([0,0,-disc_d*0.5])
            cylinder(h=disc_d*0.5, d1=1, d2=disc_d);
        }

        // cut out holes
        translate([0,0,-4*disc_th]) cylinder(h=10*disc_th, d=holes_d);
        for (i=[0:circ_holes-1]) {
            rotate([0,0, i*360/circ_holes])
            translate([holes_off_r,0,-4*disc_th])
            rotate([0,hole_rot_b,0])
            cylinder(h=10*disc_th, d=holes_d);
        }
    }
}
