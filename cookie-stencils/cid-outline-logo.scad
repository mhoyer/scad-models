height = 0.4;
width = 40;

$fn=150;

union() {
  translate([2.75, 11.4, height-0.1])
  cube(size=[14, 0.2, 0.1]);

  translate([1.87, 8.8, height-0.1])
  cube(size=[14, 0.2, 0.1]);

  translate([0.82, 6, height-0.1])
  cube(size=[14, 0.2, 0.1]);

  linear_extrude(height = height) {
    import(file = "cid-outline-logo.svg");
  }
}
