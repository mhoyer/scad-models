// dimensions of Raspberry Pi 4 w/ Armor case
charger_h = 20;
charger_w = 50.2;
charger_l = 90;
charger_chamfer_r = 0.5;

wall_thickness = 6 * 0.4;

$fn=50;

// charger debug box
// #translate([0,0,0.1]) cube([charger_h, charger_w, charger_l]);

// bracket
bracket_w = 0.2 + charger_h;
bracket_l = 0.2 + charger_w;
bracket_h = 20;
difference() {
  union() {
    difference() {
      translate([-wall_thickness, -wall_thickness, 0])
        rounded_box(bracket_w + 2*wall_thickness, bracket_l + 2*wall_thickness, bracket_h, charger_chamfer_r + wall_thickness);
      translate([0,0,-bracket_h])
        rounded_box(bracket_w, bracket_l, 3*bracket_h, charger_chamfer_r);
    }

    translate([-wall_thickness, -bracket_h-1.5*wall_thickness, 0])
      cube([wall_thickness, bracket_h+wall_thickness, bracket_h]);

    translate([-wall_thickness, bracket_l, 0])
      cube([wall_thickness, bracket_h+wall_thickness, bracket_h]);
  }

  // thin slice
  translate([0, -2*bracket_h, -bracket_h])
    cube([bracket_w - wall_thickness, 3*bracket_h, 3*bracket_h]);

  // screw holes
  translate([0, -wall_thickness-bracket_h/2, bracket_h/2])
  rotate([0, 90, 0])
    cylinder(d = 4, h = 5*wall_thickness, center = true);

  translate([0, bracket_l+wall_thickness+bracket_h/2, bracket_h/2])
  rotate([0, 90, 0])
    cylinder(d = 4, h = 5*wall_thickness, center = true);
}

module rounded_box(w, l, h, r) {
  hull() {
    cube([r,r,h]);
    translate([0, l-r, 0]) cube([r,r,h]);
    // translate([r,   l-r, 0]) cylinder(r = r, h = h);
    translate([w-r, l-r, 0]) cylinder(r = r, h = h);
    translate([w-r, r,   0]) cylinder(r = r, h = h);
  }
}