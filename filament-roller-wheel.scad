$fn = 100;
epsilon = 0.01;
nozzle_d = 0.4;

filament_wheel();

module filament_wheel(){
    // main parameters
    wt = 2; // wall thickness
    bb_d = 22 + 0.1;
    bb_h = 7;
    whl_d = bb_d + wt;
    whl_h = bb_h;

    difference(){
        union() {
            // translate([whl_d, 0, 0]) cylinder(d=bb_d, h=bb_h);

            translate([0, 0, 0]) cylinder(d=whl_d + wt, h=wt*0.25);
            translate([0, 0, wt*0.25]) cylinder(d1=whl_d + wt, d2=whl_d, h=wt*0.75);
            translate([0, 0, wt]) cylinder(d=whl_d, h=whl_h - 2*wt);
            translate([0, 0, whl_h - wt]) cylinder(d1=whl_d, d2=whl_d + wt, h=wt*0.75);
            translate([0, 0, whl_h - 0.25*wt]) cylinder(d=whl_d + wt, h=wt*0.25);
        }

        // cut out
        // translate([0, (arm_h + arm_d/2)/3.5, 8*wt])
        translate([0,0, 0.4]) cylinder(h=1000, d=bb_d);
        translate([0,0, -10]) cylinder(h=1000, d=bb_d-2*wt);
    }
}
