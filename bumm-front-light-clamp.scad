$fn = 100;
epsilon = 0.01;
nozzle_d = 0.4;

bumm_front_light_clamp();

module bumm_front_light_clamp(){
    // main parameters
    wt = 1.6; // wall thickness
    lamp_cover_main_d = 51.3;
    lamp_cover_front_d = 48.3;
    lamp_cover_h = 5;

    ring_front_d = lamp_cover_main_d;
    ring_rear_d = lamp_cover_main_d - 2*wt;
    ring_top_h = 12; // which should result in 11mm at 45/2 degrees from top
    ring_btm_h = 10;


    linear_extrude(height = 10) {
        import(file = "bumm_front_light_clamp.svg");
    }

    difference(){
        union() {
            // translate([0, 0, 0]) cylinder(d1=lamp_cover_front_d, d2=lamp_cover_main_d*0.98, h=lamp_cover_h/2*0.25);
            // translate([0, 0, lamp_cover_h/2*0.25]) cylinder(d1=lamp_cover_main_d*0.98, d2=lamp_cover_main_d, h=lamp_cover_h/2*0.75);
            // // translate([0, 0, wt*0.25]) cylinder(d1=whl_d + wt, d2=whl_d, h=wt*0.75);
            // translate([0, 0, lamp_cover_h/2]) cylinder(d=lamp_cover_main_d, h=ring_top_h-lamp_cover_h);
            // translate([0, 0, whl_h - wt]) cylinder(d1=whl_d, d2=whl_d + wt, h=wt*0.75);
            // translate([0, 0, whl_h - 0.25*wt]) cylinder(d=whl_d + wt, h=wt*0.25);
        }

        // cut out
        // translate([0,0, 0.4]) cylinder(h=1000, d=lamp_cover_main_d);
        // translate([0,0, -10]) cylinder(h=1000, d=lamp_cover_main_d-2*wt);
    }
}
