$fn = 100;
epsilon = 0.01;
nozzle_d = 0.4;

tetrahedron_stand();

module tetrahedron_stand(){
    // main parameters
    side = 30;
    edge_t = 3;

    // derived parameters
    tet_d = side * 2/ sqrt(3);
    tet_h = side * sqrt(6) / 3;
    tet_z = side * sqrt(6) / 12;
    tet_alpha = 60;
    tet_beta = atan(2 * sqrt(2));
    tet_gamma = atan(sqrt(2));

    cutout_z = tet_z + edge_t * sqrt(8);

    difference(){
        union() {
            translate([0,0,-tet_z]) cylinder($fn=3, h=tet_h, d1=tet_d, d2=epsilon);
        }

        // cut out
        translate([0,0,-cutout_z]) cylinder($fn=3, h=tet_h, d1=tet_d, d2=epsilon);
        for (i=[0:2]) {
            rotate([180, -tet_beta, i*120]) translate([0,0,-cutout_z]) cylinder($fn=3, h=tet_h, d1=tet_d, d2=epsilon);
        }
    }
}
