epsilon = 0.01;
nozzle_d = 0.4;
print = 1; // set to 0 or 1
$fn = 100;

wdt_frame();

// main parameters
// needles = 10;
// needle_d = 0.35;
// needle_l = 75; // total length
// needle_grip_d = 1.6;
// needle_grip_l = 34;

// disc_d=10;
// disc_th=2;
// btm_off_z=3;
// mid_off_z=18;
// top_off_z=btm_off_z + mid_off_z + needle_grip_l;

// height = top_off_z + 2 + 2*epsilon;
// bone_thickness = 0.8;
// bone_gap_dist = 1.6;
// diff_bone_thickness = 0.8;
// diff_bone_gap_dist = 1.6;
// diff_bone_buffer = nozzle_d/2;

module wdt_frame(){
    // main parameters
    needles = 10;
    needle_d = 0.8;
    needle_l = 75; // total length
    needle_grip_d = 1.9;
    needle_grip_l = 34;

    disc_d=12;
    disc_th=2;
    btm_off_z=3;
    mid_off_z=18;
    top_off_z=btm_off_z + mid_off_z + needle_grip_l;

    height = top_off_z + 2 + 2*epsilon;
    bone_thickness = 0.8;
    bone_gap_dist = 1.6;
    diff_bone_thickness = 1;
    diff_bone_gap_dist = 1.6;
    diff_bone_buffer = nozzle_d/1.5;

    translate([-print*1.1*disc_d, 0, -print*(top_off_z+epsilon)])
    difference(){ // top disc
        translate([0, 0, top_off_z+epsilon])
        disc_with_holes(disc_d=disc_d, circ_holes=needles-1, holes_d=needle_grip_d, holes_off_r=4, disc_th=disc_th);

        rotate([0,0,90])
        vertical_red_bone(h=height, top_off_z=top_off_z, mid_off_z=mid_off_z, btm_off_z=btm_off_z,   thkns=diff_bone_thickness, dist=diff_bone_gap_dist, buffer=diff_bone_buffer);
        vertical_green_bone(h=height, top_off_z=top_off_z, mid_off_z=mid_off_z, btm_off_z=btm_off_z, thkns=diff_bone_thickness, dist=diff_bone_gap_dist, buffer=diff_bone_buffer);
    }

    translate([0, 0, -print*(mid_off_z+epsilon)])
    difference(){ // middle disc
        translate([0, 0, mid_off_z+epsilon])
        disc_with_holes(disc_d=disc_d, circ_holes=needles-1, holes_d=2*needle_d, holes_off_r=4, disc_th=disc_th);

        rotate([0,0,90])
        vertical_red_bone(h=height, top_off_z=top_off_z, mid_off_z=mid_off_z, btm_off_z=btm_off_z,   thkns=diff_bone_thickness, dist=diff_bone_gap_dist, buffer=diff_bone_buffer);
        vertical_green_bone(h=height, top_off_z=top_off_z, mid_off_z=mid_off_z, btm_off_z=btm_off_z, thkns=diff_bone_thickness, dist=diff_bone_gap_dist, buffer=diff_bone_buffer);
    }

    translate([print*1.1*disc_d, 0, -print*(btm_off_z+epsilon)])
    difference(){ // bottom disc
        translate([0, 0, btm_off_z+epsilon])
        disc_with_holes(disc_d=disc_d, circ_holes=needles-1, holes_d=2*needle_d, holes_off_r=4.7, disc_th=disc_th);

        rotate([0,0,90])
        vertical_red_bone(h=height, top_off_z=top_off_z, mid_off_z=mid_off_z, btm_off_z=btm_off_z,   thkns=diff_bone_thickness, dist=diff_bone_gap_dist, buffer=diff_bone_buffer);
        vertical_green_bone(h=height, top_off_z=top_off_z, mid_off_z=mid_off_z, btm_off_z=btm_off_z, thkns=diff_bone_thickness, dist=diff_bone_gap_dist, buffer=diff_bone_buffer);
    }

    translate([-print*0.5*height, -print*disc_d, print*bone_thickness/2])
    rotate([print*90,0,90])
    vertical_red_bone(h=height, top_off_z=top_off_z, mid_off_z=mid_off_z, btm_off_z=btm_off_z, thkns=bone_thickness, dist=bone_gap_dist);

    translate([-print*0.5*height, print*disc_d, print*bone_thickness/2])
    rotate([print*90,0,print*90])
    vertical_green_bone(h=height, top_off_z=top_off_z, mid_off_z=mid_off_z, btm_off_z=btm_off_z, thkns=bone_thickness, dist=bone_gap_dist);
}

module disc_with_holes(disc_d=10, holes_d=1, holes_off_r=3, disc_th = 2, circ_holes = 9) {
    holes_d = max(0.8, holes_d);
    difference(){
        // the disc
        union() {
            cylinder(h=disc_th, d=disc_d);
        }

        // cut out holes
        translate([0,0,-disc_th/2]) cylinder(h=2*disc_th, d=holes_d);
        for (i=[0:circ_holes-1]) {
            rotate([0,0, i*360/circ_holes])
            translate([holes_off_r,0,-disc_th/2])
            cylinder(h=2*disc_th, d=holes_d);
        }

        // attempt: fibonacci spiral distribution
        // see: https://stackoverflow.com/a/44164075
        // for (i=[0:circ_holes]) {
        //     r = sqrt((i+1)/circ_holes);
        //     theta = PI * (1 + 5^0.5) * i;
        //     rotate([0,0, theta*10])
        //     translate([holes_off_r*r,0,-disc_th/2])
        //     cylinder(h=2*disc_th, d=holes_d);
        // }
    }
}

module vertical_red_bone(h=50, top_off_z=40, mid_off_z=18, btm_off_z=5, thkns=0.8, dist=1.4, buffer=0){
    difference() {
        color("red") union() {
            // bridge
            translate([0,0,3*btm_off_z/4 + epsilon]) cube([thkns+dist+epsilon, thkns, btm_off_z/2], center=true);

            translate([-dist,0,h/2]) cube([thkns+buffer, thkns+buffer, h], center=true);
            translate([ dist,0,h/2]) cube([thkns+buffer, thkns+buffer, h], center=true);

            translate([-(dist + .5*thkns - epsilon),0,top_off_z/2]) cube([2*thkns+buffer, thkns+buffer, top_off_z], center=true);
            translate([ (dist + .5*thkns - epsilon),0,top_off_z/2]) cube([2*thkns+buffer, thkns+buffer, top_off_z], center=true);

            translate([-(dist + thkns - 2*epsilon),0,btm_off_z/2]) cube([3*thkns+buffer, thkns+buffer, btm_off_z], center=true);
            translate([ (dist + thkns - 2*epsilon),0,btm_off_z/2]) cube([3*thkns+buffer, thkns+buffer, btm_off_z], center=true);
        }

        translate([0,thkns/2.1,0]) cube([thkns/3, thkns, h], center=true);
    }
}

module vertical_green_bone(h=50, top_off_z=40, mid_off_z=18, btm_off_z=5, thkns=0.8, dist=1.4, buffer=0){
    difference() {
        color("green") union() {
            // bridge
            translate([0,0,btm_off_z/4]) cube([thkns+dist+epsilon, thkns, btm_off_z/2], center=true);

            translate([-dist,0,h/2]) cube([thkns+buffer, thkns+buffer, h], center=true);
            translate([ dist,0,h/2]) cube([thkns+buffer, thkns+buffer, h], center=true);

            translate([-(dist + .5*thkns - epsilon),0,mid_off_z/2]) cube([2*thkns+buffer, thkns+buffer, mid_off_z], center=true);
            translate([ (dist + .5*thkns - epsilon),0,mid_off_z/2]) cube([2*thkns+buffer, thkns+buffer, mid_off_z], center=true);

            translate([-(dist + thkns - 2*epsilon),0,btm_off_z/2]) cube([3*thkns+buffer, thkns+buffer, btm_off_z], center=true);
            translate([ (dist + thkns - 2*epsilon),0,btm_off_z/2]) cube([3*thkns+buffer, thkns+buffer, btm_off_z], center=true);
        }

        translate([0,thkns/2.1,0]) cube([thkns/3, thkns, h], center=true);
    }
}
