// dimensions of Raspberry Pi 4 w/ Armor case
rpi_h = 24.1;
rpi_w = 56;
rpi_l = 88.24;

bottom_armor_h = 4.6;
top_armor_display_port_pocket_h = 16.25;
top_armor_display_port_pocket_w = 22.4;
top_armor_display_port_pocket_l = 3.5;

wall_thickness = 6 * 0.4;
wmount_w = 15;
screw_buffer_h = 2;

$fn=100;

// rpi4 debug box
#translate([0,0,0.1]) cube([rpi_l, rpi_w, rpi_h]);

USBSide();
// SDSlotSide();

module USBSide() {
  translate([0,0,-wall_thickness])
  difference() {
    union() {
      // base plate for wall mount
      hull() {
        translate([wmount_w/4,   wmount_w/4, 0]) cylinder(d = wmount_w/2, h=wall_thickness);
        translate([wmount_w/2,   rpi_w,      0]) cylinder(d = wmount_w, h=wall_thickness);
        translate([3*wmount_w/4, wmount_w/4, 0]) cylinder(d = wmount_w/2, h=wall_thickness);
      }
      translate([wmount_w/3,   wmount_w/2,       0]) cylinder(d = wmount_w/3, h=screw_buffer_h + wall_thickness);
      translate([4*wmount_w/5,   rpi_w-wmount_w/5, 0]) cylinder(d = wmount_w/3, h=screw_buffer_h + wall_thickness);

      // guides (long sides)
      guide_h = 1.5 * bottom_armor_h + screw_buffer_h + wall_thickness;
      translate([wmount_w/4, -.25, 0]) cube([wmount_w/2, rpi_w+0.5, wall_thickness]);
      translate([wmount_w/4, -wall_thickness-0.1, 0]) cube([wmount_w/3, wall_thickness, guide_h]);
      translate([0, rpi_w+0.1, 0]) cube([wmount_w/3, wall_thickness, guide_h]);

      // bracket
      braket_h = bottom_armor_h + 1 + screw_buffer_h;
      braket_w = rpi_w/2;
      braket_l = top_armor_display_port_pocket_l + wall_thickness;

      translate([0, 7*(rpi_w-braket_w)/8, 0])
      union() {
        translate([-.25, 0, 0]) cube([wmount_w/2, braket_w,  wall_thickness]);
        translate([-wall_thickness, 0, 0])          cube([wall_thickness, braket_w, braket_h]);
        translate([-wall_thickness, 0, braket_h+0]) cube([braket_l, braket_w, wall_thickness]);
      }
    }

    // screw holes
    screw_hole_d = 3.2;
    translate([4*wmount_w/5,   wmount_w/5,     -wall_thickness]) cylinder(d = screw_hole_d, h = 3*wall_thickness);
    translate([wmount_w/2,   rpi_w+wmount_w/4, -wall_thickness]) cylinder(d = screw_hole_d, h = 3*wall_thickness);

    // material cut out
    translate([11.5*rpi_w/20, rpi_w/2, -wall_thickness]) cylinder(d = rpi_w, h = 3*wall_thickness);
  }
}

module SDSlotSide() {
  translate([0,0,-wall_thickness])
  difference() {
    union() {
      // base plate for wall mount
      hull() {
        translate([wmount_w/4,   wmount_w/4,       0]) cylinder(d = wmount_w/2, h=wall_thickness);
        translate([wmount_w/4,   rpi_w-wmount_w/4, 0]) cylinder(d = wmount_w/2, h=wall_thickness);
        translate([3*wmount_w/4, wmount_w/4,       0]) cylinder(d = wmount_w/2, h=wall_thickness);
        translate([3*wmount_w/4, rpi_w-wmount_w/4, 0]) cylinder(d = wmount_w/2, h=wall_thickness);
      }
      translate([4*wmount_w/5,   wmount_w/5,       0]) cylinder(d = wmount_w/3, h=screw_buffer_h + wall_thickness);
      translate([4*wmount_w/5,   rpi_w-wmount_w/5, 0]) cylinder(d = wmount_w/3, h=screw_buffer_h + wall_thickness);

      // guides (long sides)
      guide_h = 1.5 * bottom_armor_h + screw_buffer_h + wall_thickness;
      translate([wmount_w/4, -.25, 0]) cube([wmount_w/2, rpi_w+0.5, wall_thickness]);
      translate([wmount_w/4, -wall_thickness-0.1, 0]) cube([wmount_w/2, wall_thickness, guide_h]);
      translate([wmount_w/4, rpi_w+0.1, 0]) cube([wmount_w/2, wall_thickness, guide_h]);

      // bracket
      braket_h = top_armor_display_port_pocket_h + 1 + screw_buffer_h;
      braket_w = top_armor_display_port_pocket_w - 0.2;
      braket_l = top_armor_display_port_pocket_l + wall_thickness;

      translate([0, (rpi_w-braket_w)/2, 0])
      difference() {
        union() {
          translate([-.25, 0, 0]) cube([wmount_w/2, braket_w,  wall_thickness]);
          translate([-wall_thickness, 0, 0]) cube([wall_thickness, braket_w, braket_h]);
          translate([-wall_thickness, 0, braket_h+0]) cube([braket_l, braket_w, wall_thickness]);
        }
        // SD Card hole
        translate([-2*wall_thickness, 4, 4]) cube([4*wall_thickness, braket_w-8, braket_h-8]);
      }
    }

    // screw holes
    screw_hole_d = 3.2;
    translate([wmount_w/2,   wmount_w/2,       -wall_thickness]) cylinder(d = screw_hole_d, h = 3*wall_thickness);
    translate([wmount_w/2,   rpi_w-wmount_w/2, -wall_thickness]) cylinder(d = screw_hole_d, h = 3*wall_thickness);

    // material cut out
    translate([11.5*rpi_w/20, rpi_w/2, -wall_thickness]) cylinder(d = rpi_w, h = 3*wall_thickness);
  }
}
