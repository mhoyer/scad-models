$fn=80;
epsilon = 0.01;
// dimensions of Raspberry Pi 4 w/ Armor case
rpi_h = 24.1;
rpi_w = 56;
rpi_l = 88.24;

bottom_armor_h = 4.6;
top_armor_display_port_pocket_h = 16.25;
top_armor_display_port_pocket_w = 22.4;
top_armor_display_port_pocket_l = 3.5;

wt = 3.2;

union() {
  color("green")
  base_plate();
  main_frame();
}

module base_plate() {
  plate_l = rpi_l/1.5;
  plate_w = rpi_w + 2*wt;
  plate_off_x = (rpi_l - plate_l)/2 + wt;

  // 4 screw holes
  screw_dist_x = 21.14 - 5.26;
  screw_dist_y = 46.5;

  screw_off_x = 10.3;
  screw_off_y = 22;

  screw_d = 3.2;

  translate([plate_off_x, 0, -rpi_h/2 - 1.25*wt + epsilon])
  difference() {
    union() {
      cube([plate_l, plate_w, wt/2], center=true);
    }

    translate([-wt, plate_w/2 - screw_dist_x/2 - screw_off_x, -500])
    union() {
      translate([screw_dist_y/2, screw_dist_x/2, 0])
      cylinder(d=screw_d, h=1000);

      translate([-screw_dist_y/2, screw_dist_x/2, 0])
      cylinder(d=screw_d, h=1000);

      translate([screw_dist_y/2, -screw_dist_x/2, 0])
      cylinder(d=screw_d, h=1000);

      translate([-screw_dist_y/2, -screw_dist_x/2, 0])
      cylinder(d=screw_d, h=1000);
    }

    hull() {
      translate([-7,0,0])
      rotate([0,0,45])
      cube([plate_w/2 / sqrt(2), plate_w/2 / sqrt(2),20], center=true);

      translate([4,0,0])
      cube([plate_l/2.5,plate_w/2,20], center=true);
    }
  }
}

module main_frame() {
  difference() {
    union() {
      cube([rpi_l + 2*wt, rpi_w + 2*wt, rpi_h + 2*wt], center=true);
    }

    // cutout in direction of x-axis
    translate([-2*wt,0,0])
    cube([rpi_l + 4*wt, rpi_w, rpi_h], center=true);

    // slot for audio and usb ports
    translate([-3*wt, rpi_w/2, -2])
    cube([rpi_l + 4*wt, 3, rpi_h/2.5], center=true);

    cube([2*rpi_l, rpi_w - 2*wt, rpi_h - 2*wt], center=true);

    intersection() {
      h = 1;
      a = 2 * h / sqrt(3);
      ru = a/sqrt(3);
      ri = a/2/sqrt(3);
      scale([rpi_l - 2*wt, 2*rpi_w, 2*rpi_h])
      rotate([90,0,180])
      translate([ri - h/2, 0, 0])
      cylinder($fn=3, r=ru, h=1, center=true);

      cube([rpi_l - 2*wt, 2*rpi_w, rpi_h - 2*wt], center=true);
    }

    intersection() {
      h = rpi_l - 2*wt;
      a = 2 * h / sqrt(3);
      ru = a/sqrt(3);
      ri = a/2/sqrt(3);
      rotate([0,0,180])
      translate([ri - h/2, 0, 0])
      cylinder($fn=3, r=ru, h=2*rpi_h, center=true);

      cube([rpi_l - 2*wt, rpi_w - 2*wt, 2*rpi_h], center=true);
    }
  }
}
