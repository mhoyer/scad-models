height = 1.5;
width = 40;

$fn=150;

rotate([0, 180, 0])
// scale([.9, .9, .9])
union() {
  #translate([width/2, width/2, 0])
  difference() {
    cylinder(d=width+2, h=height+2);

    translate([0, 0, -0.02])
    cylinder(d=width, h=height);
  }

  translate([0, 0, -0.4])
  linear_extrude(height = height+0.8) {
    offset(delta=0.001)
    import(file = "fmbi.svg");
  }
}