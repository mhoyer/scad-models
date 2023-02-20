$fn = 100;
epsilon = 0.01;
nozzle_d = 0.4;

rotate([90,0,0])
filament_arm();

module filament_arm(){
    // main parameters
    wt = 3.2; // wall thickness
    arm_l = 85;
    arm_d = 34.4;
    arm_h = 12;
    main_arm_th = 2;

    // derived parameters
    arm_hull_l = arm_l + wt;
    arm_hull_d = arm_d + 2*wt;
    arm_hull_h = arm_h + 2*wt;
    bolt_d = 12;
    bolt_h = 30;
    bolt_head_h = 12;
    bolt_head_d = bolt_d + 2*wt;

    difference(){
        union() {
            translate([0, arm_hull_h/2, 0]) cylinder(d=arm_hull_d, h=arm_hull_l);
            translate([0, arm_hull_h/4, arm_hull_l/2]) cube([arm_hull_d, arm_hull_h/2, arm_hull_l], center=true);
        }

        // cut out
        translate([0, (arm_h + arm_d/2)/3.5, 8*wt])
        rotate([0,0,-30])
        cylinder($fn=3, h=arm_l, d=arm_d);

        // main arm hinge
        translate([0, arm_h*0.5 - 2*epsilon, wt + main_arm_th/2]) cube([arm_d, arm_h, main_arm_th], center=true);

        // flat plane
        color("green")
        translate([0, -50+epsilon, 50]) cube([100,100,200], center=true);

        // stabelization hole
        translate([0, bolt_h/2 - bolt_head_h, 2*wt + main_arm_th + (bolt_d+nozzle_d)*0.5])
        rotate([90,0,0])
        cylinder(d=bolt_d+nozzle_d, h=bolt_h, center=true);
    }

    // #translate([0, bolt_h/2 - bolt_head_h, 2*wt + main_arm_th + (bolt_d+nozzle_d)*0.5])
    translate([0, bolt_h/2, -bolt_head_d])
    rotate([90,0,0])
    union() {
        // rotate([90,0,0])
        cylinder(d=bolt_d, h=bolt_h, center=true);

        translate([0,0,(bolt_h-bolt_head_h)/2])
        cube([bolt_head_d, bolt_head_d, bolt_head_h], center=true);
    }
}
