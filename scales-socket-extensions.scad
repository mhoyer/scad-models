wall_thickness = 4 * 0.4;
inner_diameter = 16.5;
outer_diameter = inner_diameter + 2*wall_thickness;
height = 10;


$fn=50;

difference() {
    cylinder(d = outer_diameter, h = height, center = false);
    translate([0,0,height-2.2])
      cylinder(d = inner_diameter, h = 2*height, center = false);
}
