$fn = 100;
epsilon = 0.01;
nozzle_d = 0.4;

gravitrax_leveler();

module gravitrax_leveler(){
    outer_w = 45; outer_d = 2*outer_w / sqrt(3);
    inner_w = 29.7; inner_d = 2*inner_w / sqrt(3);
    height = 10;
    holes_d = 4 + nozzle_d;
    holes_h = 6;

    chamfer_h = 1.2;
    inner_h = height - 2*chamfer_h;
    extrusion_h = 3 * chamfer_h;
    extrusion_t = 1.2;

    difference(){
        union(){
            // main hex
            translate([0,0,inner_h])     cylinder($fn=6, h=chamfer_h, d1=outer_d, d2=outer_d-chamfer_h);
            translate([0,0,0])           cylinder($fn=6, h=inner_h,   d=outer_d);
            translate([0,0,-chamfer_h])  cylinder($fn=6, h=chamfer_h, d1=outer_d-chamfer_h, d2=outer_d);

            // inner extrusion
            translate([0,0,extrusion_h]) cylinder($fn=6, h=inner_h,   d=inner_d);
        }

        // cut out
        translate([0,0,-chamfer_h - epsilon]) cylinder($fn=6, h=height+extrusion_h, d1=inner_d+0.5, d2=inner_d-2*extrusion_t);

        // holes
        holes_offset_d = (outer_d + inner_d - holes_d)/4 + extrusion_t/2;
        for (i=[0:2]) {
            // bottom
            rotate([0,0,120*i])
            translate([holes_offset_d, 0, holes_h/2 - chamfer_h - epsilon])
            cylinder(d=holes_d, h=holes_h, center=true);

            // top
            rotate([0,0,120*i+60])
            translate([holes_offset_d, 0, -holes_h/2 + chamfer_h + inner_h + epsilon])
            cylinder(d=holes_d, h=holes_h, center=true);
        }
    }
}
