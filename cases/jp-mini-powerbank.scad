bat_d = 18.2+1; bat_l = 64.5 + 7;

board_w = 25.6;    board_l = 65.7;      board_h = 3;
musb_w = 5.6;      musb_l = 7.4;        musb_h = 2.4;      musb_y = 6.5;
usbc_w = 6.4;      usbc_l = 8.9;        usbc_h = 3.1;      usbc_y = 17.1;
usba_w = 10;       usba_l = 13.2;       usba_h = 5.7;      usba_y = [29.2, 47];
disp_w = 12.9;     disp_l = 26.4;       disp_h = 5.6; disp_y = 18; disp_x = 9.8;
lightning_w = 7.7; lightning_l = 9.6;   lightning_h = 3.1; lightning_x = 11.2;
ports_overlap = 1.8;
wall_thickness = 1.2;

$fn=100;

// board and bat
union() {
  // main board
  cube([board_w, board_l, board_h+0.001]);

  // front components
  translate([-ports_overlap,0,board_h]) {
    translate([0,musb_y,0])
    cube([musb_w, musb_l, musb_h]);

    translate([0,usbc_y,0])
    cube([usbc_w, usbc_l, usbc_h]);

    translate([0,usba_y[0],0])
    cube([usba_w, usba_l, usba_h]);

    translate([0,usba_y[1],0])
    cube([usba_w, usba_l, usba_h]);
  }

  // bottom components
  translate([0, -ports_overlap, board_h]) {
    translate([lightning_x,0,0])
    cube([lightning_l, lightning_w, lightning_h]);
  }

  // display
  translate([0,0, board_h]) {
    translate([disp_x,disp_y,0])
    cube([disp_w, disp_l, disp_h]);
  }
}

color([.25, .5, 0, .5])
difference() {
  // outer
  translate([board_w/2, -wall_thickness, board_w/2 - bat_d - wall_thickness])
  union() {
    rotate([-90, 0, 0])
    cylinder(d=board_w + 2*wall_thickness, h=bat_l + 2*wall_thickness);

    translate([-(board_w/2 + wall_thickness),0,0])
    cube([board_w + 2*wall_thickness, bat_l + 2*wall_thickness, 30]);
  }

  // cutout
  union() {
    // battery
    scale([1, 2, 1])
    translate([board_w/2, 0, -bat_d/2 - wall_thickness])
    rotate([-90, 0, 0])
    cylinder(d=bat_d, h=bat_l);

    // main board
    cube([board_w, board_l, board_h+0.001]);

    // top
    translate([-4*wall_thickness, -4*wall_thickness, board_h-.01])
    cube([2*board_w, 2*board_l, 42]);
  }
}
