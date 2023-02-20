valve_h = 65;
valve_outer_d = 48.8;
valve_outer_th = 2;
valve_inner_r = (valve_outer_d/2 - valve_outer_th);


$fn=150;

// valve body
#difference(){
    translate([0,0,.01])
    cylinder(d=valve_outer_d, h=valve_h);

    translate([0,0,-1])
    cylinder(d=valve_outer_d-valve_outer_th*2, h=70);
}

// lower support (stick)
support_h = 29.6; // full height
support_lower_h = 16.1;
support_lower_off = valve_h - support_h;
color([0,.99,.99,.6])
translate([-5, valve_inner_r, support_lower_off])
linear_extrude(height=support_lower_h+.01) {
    polygon(points=[
        [0, -0.6],
        [2.5, -0.15],
        [4.4, 0],
        [5, 0],
        [3.2, -3],
        [2.3, -6.4],
        [2, -6.5]]);
}

// middle support block
support_middle_h = 8.2;
support_middle_off = support_lower_off + support_lower_h;
color([0.5,.5,.99,.6])
translate([-5, valve_inner_r, support_middle_off])
linear_extrude(height=support_middle_h+.01) {
    polygon(points=[
        [0, -0.6],
        [2.5, -0.15],
        [4.4, 0],
        [4.5, 0.4],
        [5, 0.4],
        [5, 2],
        [7, 1.95],
        [9, 1.7],
        [10, 1.5],
        [10.5, 1.4],
        [11.5, 1.1],
        [11.5, 0],
        [6.4, -2.9], // bat notch
        [4, -6.5],
        [2, -6.5]]);
}

// upper support block
support_upper_h = 3.1;
support_upper_off = support_middle_off + support_middle_h;
color([0,.99,.2,.6])
translate([-5, valve_inner_r, support_upper_off])
linear_extrude(height=support_upper_h+.01) {
    polygon(points=[
        [2.5, -0.6],
        [2.5, -0.15],
        [4.4, 0],
        [4.5, 0.4],
        [5, 0.4],
        [5, 0.75],
        [7, 0.65],
        [9, 0.45],
        [9.7, 0.32],
        [10, 1.5],
        [10.5, 1.4],
        [11.5, 1.1],
        [11.5, 0],
        [6.4, -2.9], // bat notch
        [4, -6.5],
        [3.7, -6.5]]);
}

// top support block
support_top_h = support_h - support_lower_h - support_middle_h - support_upper_h;
support_top_off = support_upper_off + support_upper_h;
color([0.6,.6,.2,.6])
translate([-5, valve_inner_r, support_top_off])
linear_extrude(height=support_top_h+.01) {
    polygon(points=[
        [3.3, -0.6],
        [3.3, -0.08],
        [4.4, 0],
        [4.5, 0.4],
        [5, 0.4],
        [5, 0.75],
        [7, 0.65],
        [7.1, 1.95],
        [9, 1.7],
        [10, 1.5],
        [10.5, 1.4],
        [11.5, 1.1],
        [11.5, 0],
        [6.4, -2.9], // bat notch
        [4, -6.5],
        [3.7, -6.5]]);
}
