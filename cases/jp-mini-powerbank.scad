bat_d = 18.2+0.5; bat_l = 64.5 + 7;

buf=0.3;
wall_thickness = 2;
board_w = 25.5+buf;board_l = 65.7+buf;  board_h = 3;
musb_w = 5.6;      musb_l = 7.6;        musb_h = 2.4; musb_x = -1.8;  musb_y = 6.0;
usbc_w = 6.4;      usbc_l = 9.1;        usbc_h = 3.1; usbc_x = -1.21; usbc_y = 16.8;
usba_w = 10;       usba_l = 13.4;       usba_h = 5.8; usba_x = -1.36; usba_y = [29.2, 45.4]; usba_z = 0.6;
disp_w = 13.5;     disp_l = 27;         disp_h = 5.6; disp_x = 10;  disp_y = 18.5;
lightning_w = 7.7; lightning_l = 10.0;  lightning_h = 3.1; lightning_x = 11.2; lightning_y = -1.5;
sw_w = 1;          sw_l = 3;            sw_h = 1;     sw_x = 15.8;   sw_y   = board_l; sw_z = 1;
screw_d = 3; screw_l = 4;
epsilon=0.01;

$fn=100;

difference() {
  union() {
    // color("green") board();

    // translate([0, 0, 10])
    // color("yellow") top_cover();

    // color("red") battery_belly();

    back_clip();
    // front_clip();
  }

  // translate([26, -10, -50])
  // translate([-50, -30, -50])
  // cube(size=[100, 100, 100]);
}

module board() {
  translate([buf/2, buf/2, 0])
  union() {
    // main board
    translate([0,0,board_h-0.8])
    cube([board_w-buf, board_l-buf, 0.8+epsilon]);

    translate([0,0,board_h]) {
      // front components
      translate([musb_x-wall_thickness, musb_y, 0])
      cube([musb_w+wall_thickness, musb_l, musb_h+buf/2]);

      translate([usbc_x-wall_thickness,usbc_y,0])
      cube([usbc_w+wall_thickness, usbc_l, usbc_h+buf/2]);

      translate([usba_x-wall_thickness,usba_y[0],usba_z])
      cube([usba_w+wall_thickness, usba_l, usba_h+buf/2]);

      translate([usba_x-wall_thickness,usba_y[1],usba_z])
      cube([usba_w+wall_thickness, usba_l, usba_h+buf/2]);

      // bottom components
      translate([lightning_x, lightning_y-wall_thickness, 0])
      cube([lightning_l, lightning_w+wall_thickness, lightning_h+buf/2]);

      // switch
      translate([sw_x,sw_y,sw_z])
      cube([sw_l, sw_w, sw_h]);

      // display
      translate([disp_x, disp_y, 0])
      cube([disp_w, disp_l, disp_h]);
    }
  }
}

module support_noses() {
  union() {
    translate([0, 0, board_h]) {
      translate([3,-epsilon,wall_thickness])
      cube([5, 1.5*wall_thickness, wall_thickness]);
    }
  }
}

module switch_hole() {
  translate([sw_x+sw_l/2, bat_l+1.2*screw_l, board_h+sw_z+sw_h/2])
  rotate([90,0,0])
  cylinder(d=screw_d, h=2*screw_l);
}

module top_cover() {
  difference() {
    union() {

      difference() {
        union() {
          // outer/upper block
          translate([-wall_thickness, -wall_thickness, board_h+musb_h+buf/2])
          cube([board_w + 2*wall_thickness, bat_l + 2*wall_thickness, usba_h+usba_z-musb_h+wall_thickness]);

          // inner block
          translate([buf/2 - 0.25*wall_thickness, buf/2, board_h+usba_z+epsilon])
          cube([board_w-buf + 0.5*wall_thickness, bat_l-buf, usba_h+usba_z]);
        }

        // cutout
        union() {
          // main board block
          translate([0.5*wall_thickness, 0.5*wall_thickness, board_h-epsilon])
          cube([board_w - 1.0*wall_thickness, bat_l - 1.0*wall_thickness, usba_h+usba_z+buf/2]);

          // display
          translate([0,0, board_h]) {
            translate([disp_x+wall_thickness/2,disp_y+wall_thickness/2,0])
            cube([disp_w-wall_thickness, disp_l-wall_thickness, 10*disp_h]);
          }

          translate([0,0, -epsilon]) {
            board();

            // extra USB-A cutouts
            translate([0,0,board_h]) {
              // front components
              translate([usba_x-usba_w, usba_y[0], usba_z-usba_h])
              cube([usba_w+2*wall_thickness, usba_l, 2*usba_h+buf/2]);

              translate([usba_x-usba_w, usba_y[1], usba_z-usba_h])
              cube([usba_w+2*wall_thickness, usba_l, 2*usba_h+buf/2]);
            }
          }
        }
      }

      // inner display hood
      translate([buf/2, buf/2, board_h+wall_thickness])
      difference() {
        union() {
          translate([disp_x - 0.6*wall_thickness, disp_y-wall_thickness-buf, 0])
          cube([disp_w + 1.2*wall_thickness, disp_l+2*wall_thickness+2*buf, disp_h]);
        }

        translate([0, 0, -epsilon]) {
          translate([disp_x - buf, disp_y - wall_thickness/4-buf, 0])
          cube([disp_w + 2*buf, disp_l + wall_thickness/2+2*buf, 2*disp_h]);
        }
      }

      // switch hole handle
      translate([board_w/2 - buf/2, bat_l+wall_thickness-screw_l-buf/2, 2*buf])
      cube([board_w/2, screw_l-wall_thickness, usba_h+board_h+wall_thickness]);
    }

    switch_hole();
  }
}

module battery_belly() {
  difference() {
    union() {
      // support bars below main board
      translate([-epsilon-buf, -epsilon, 0])
      cube([board_w+2*buf,6,2]);

      translate([-epsilon-buf, usbc_y+usbc_l/2-1,0])
      cube([board_w+2*buf,2,2]);

      translate([-epsilon-buf, usba_y[1]+1, 0])
      cube([board_w+2*buf,2,2]);

      translate([-epsilon-buf, board_l-6+epsilon, 0])
      cube([board_w+2*buf,6,2]);

      difference() {
        // outer
        union() {
          translate([0, -wall_thickness, 0])
          hull() {
            translate([-wall_thickness,0,0])
            cube([board_w + 2*wall_thickness, bat_l + 2*wall_thickness, board_h+usba_h]);

            translate([(board_w-bat_d)/2 + wall_thickness/2, 0, -(bat_d + 1.3*wall_thickness)])
            cube([bat_d-wall_thickness, bat_l + 2*wall_thickness, wall_thickness/2]);
          }
        }

        // cutout
        union() {
          // battery
          scale([1, 2, 1])
          translate([board_w/2, 0, -bat_d/2 - wall_thickness/2])
          rotate([-90, 0, 0])
          cylinder(d=bat_d, h=bat_l);

          // main board
          translate([-0.25*wall_thickness, 0, 0])
          cube([board_w + 0.5*wall_thickness, bat_l, board_h+epsilon+11]);

          // top
          translate([-4*wall_thickness, -4*wall_thickness, board_h+musb_h-epsilon])
          cube([2*board_w, 2*board_l, 16]);

          board();

          // extra USB-A cutouts
          translate([0,0,board_h]) {
            // front components
            translate([usba_x-usba_w, usba_y[0], usba_z-buf])
            cube([usba_w+2*wall_thickness, usba_l+buf/2, 2*usba_h+buf/2]);

            translate([usba_x-usba_w, usba_y[1], usba_z-buf])
            cube([usba_w+2*wall_thickness, usba_l+buf/2, 2*usba_h+buf/2]);
          }
        }
      }
    }

    // bat slice
    translate([(board_w-bat_d*0.7)/2, 2*wall_thickness, -2*board_h])
    cube([bat_d*0.7, bat_l-4*wall_thickness, 20]);

    // switch hole
    switch_hole();
  }
}

clip_buf=0.1;
module clip() {
  difference() {
    // outer hull
    hull() {
      translate([-2*wall_thickness, -2*wall_thickness, 0])
      cube([board_w + 4*wall_thickness, bat_l + 4*wall_thickness, usba_h+usba_z+board_h+2*wall_thickness]);

      translate([(board_w-bat_d+2*wall_thickness)/2 -wall_thickness, -2*wall_thickness, -bat_d-2.3*wall_thickness])
      cube([bat_d,  bat_l + 4*wall_thickness, wall_thickness]);
    }

    // cutout
    hull() {
      translate([-wall_thickness-clip_buf, -wall_thickness, 0])
      cube([
        board_w + 2*wall_thickness + 2*clip_buf,
        bat_l + 2*wall_thickness,
        usba_h+usba_z+board_h+wall_thickness+2*clip_buf]);

      translate([(board_w-bat_d+wall_thickness)/2-clip_buf, -wall_thickness, -bat_d-1.3*wall_thickness-clip_buf])
      cube([bat_d - wall_thickness + 2*clip_buf, bat_l + 2*wall_thickness, wall_thickness]);
    }

    // front cutout
    hull() {
      translate([0, -5, 0])
      cube([board_w, 10, usba_h+usba_z+board_h]);

      translate([(board_w-bat_d)/2+wall_thickness, -5, -bat_d])
      cube([bat_d - 2*wall_thickness, 10, 3*wall_thickness]);
    }

    switch_hole();
  }
}

module back_clip() {
  difference() {
    clip();

    translate([-board_w/2, -12.5, -board_w])
    cube([2*board_w, bat_l, 2*board_w]);
  }
}

module front_clip() {
  difference() {
    clip();

    translate([-board_w/2, 10-wall_thickness, -board_w])
    cube([2*board_w, 4*bat_l, 2*board_w]);

    translate([-5-wall_thickness, 7-wall_thickness, board_h+musb_h/2-3])
    cube([10,10,6]);
  }
}
