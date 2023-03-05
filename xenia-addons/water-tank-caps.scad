$fn=80;
hole_d=20;
h=4;
cap_th=0.2;
wall_th=1.2;

translate([0,0,-cap_th/2])
cylinder(d=hole_d+4*wall_th, h=cap_th);

difference(){
    cylinder(d1=hole_d, d2=hole_d-wall_th/2, h=h);

    translate([0,0,-1])
    cylinder(d=hole_d-2*wall_th, h=2*h);
}
