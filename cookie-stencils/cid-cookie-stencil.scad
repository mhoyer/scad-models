height = 5;
width = 40;

$fn=50;

rotate([0, 180, 0])
scale([2.5, 2.5, 2.5]) {

  *translate([0, 0, height+2])
  union() {
    // translate([8.7, 8.7, 2])
    // cylinder(d=3, h=6);

    translate([0, 0, 1.1])
    linear_extrude(height = height) {
      import(file = "cid-cookie-base.svg");
    }
    linear_extrude(height = 2) {
      import(file = "cid-cookie-emboss.svg");
    }
  }

  linear_extrude(height = height/1.2) {
    import(file = "cid-cookie-frame3.svg");
  }
}