rpi_w = 30;
rpi_l = 66;

gpio_cutout_w = 8.3;
gpio_cutout_l = 53.7;
gpio_offset_x = -0.01;
gpio_offset_y = 5.6;

lirc_cutout_w = 17.3;
lirc_cutout_l = 9;
lirc_offset_x = 10.1;
lirc_offset_y = 48;

soundcard_cutout_w = 17;
soundcard_cutout_l = 32;
soundcard_offset_x = 11.5;
soundcard_offset_y = 6;

$fn=100;

union() {
  // layer 1 (ground)
  ground_thickness = 0.8;
  difference() {
    cube([rpi_w, rpi_l, ground_thickness]);

    translate([0, 0, -0.1])
    scale([1, 1, 2]) {
      translate([gpio_offset_x, gpio_offset_y, 0])
      cube([gpio_cutout_w, gpio_cutout_l, ground_thickness]);
    }
  }

  // layer 2 (sinks)
  sinks_thickness = 2.5;
  translate([0,0,ground_thickness-0.01])
  difference() {
    cube([rpi_w, rpi_l, sinks_thickness]);

    translate([0, 0, -0.1])
    scale([1, 1, 2]) {
      translate([gpio_offset_x, gpio_offset_y, 0])
      cube([gpio_cutout_w, gpio_cutout_l, sinks_thickness]);

      translate([lirc_offset_x, lirc_offset_y, 0])
      cube([lirc_cutout_w, lirc_cutout_l, sinks_thickness]);

      translate([soundcard_offset_x, soundcard_offset_y, 0])
      cube([soundcard_cutout_w, soundcard_cutout_l, sinks_thickness]);
    }
  }

  translate([0,0,ground_thickness+sinks_thickness-0.01])
  union() {
    translate([soundcard_offset_x, 0, 0])
    cube([soundcard_cutout_w-6, soundcard_offset_y, 4.3]);

    translate([lirc_offset_x, soundcard_offset_y+soundcard_cutout_l, 0])
    cube([lirc_cutout_w, 3, 4.3]);

    translate([lirc_offset_x, lirc_offset_y+lirc_cutout_l, 0])
    cube([lirc_cutout_w, 3, 4.3]);
  }
}