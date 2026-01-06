$fn=100;
epsilon=0.01;
infinity=1000;

pcb_thickness = 1.2;
pcb_length = 51.3;
pcb_width = 25.46;
pcb_bottom_parts_thickness = 3.45;

display_thickness = 1.4;
display_length = 31;
display_width = 17.6;
display_offset = [ 14, 3.8, 2 ];

push_btn_diameter = 3;
push_btn_height = 2.5;
lower_push_btn_offset = [
    1.9+push_btn_diameter/2,
    4.3,
    pcb_thickness
];
upper_push_btn_offset = [
    lower_push_btn_offset[0],
    pcb_width-lower_push_btn_offset[1],
    lower_push_btn_offset[2]
];

reset_btn_length = 2;
reset_btn_width = 1;
reset_btn_height = 0.93;
reset_btn_offset = [10.9, -0.8, 1.6];

usb_port_length = 7.5;
usb_port_width = 8.95;
usb_port_thickness = 3.3;
usb_offset = [
    -1.5,
    pcb_width/2 - usb_port_width/2,
    pcb_thickness+usb_port_thickness/2
];


module pcb() {
    cube([pcb_length, pcb_width, pcb_thickness]);
}

module display() {
    translate(display_offset)
    cube([display_length, display_width, display_thickness]);
}

module buttons() {
    translate(lower_push_btn_offset)
    scale([1, 0.8, 1])
    cylinder(r=push_btn_diameter/2, h=push_btn_height);

    translate(upper_push_btn_offset)
    scale([1, 0.8, 1])
    cylinder(r=push_btn_diameter/2, h=push_btn_height);

    translate(reset_btn_offset)
    cube(size=[reset_btn_length, reset_btn_width, reset_btn_height]);
}

module usb_port(scale_factor=1) {
    translate(usb_offset)
    rotate([0, 90, 0])
    hull() {
        translate([0, usb_port_thickness/2, 0])
        scale([scale_factor, scale_factor, scale_factor])
        cylinder(d=usb_port_thickness, h=usb_port_length);

        translate([0, usb_port_width-usb_port_thickness/2, 0])
        scale([scale_factor, scale_factor, scale_factor])
        cylinder(d=usb_port_thickness, h=usb_port_length);
    }
}

case_thickness = 1.2;
module bottom_case() {
    difference() {
        // main body
        union() {
            translate([-case_thickness, -case_thickness, -(pcb_bottom_parts_thickness + case_thickness)])
            cube(size=[
                pcb_length + 2*case_thickness,
                pcb_width + 2*case_thickness,
                pcb_bottom_parts_thickness + pcb_thickness + case_thickness
            ]);

            translate([-case_thickness/2, -case_thickness/2, pcb_thickness-epsilon])
            cube(size=[
                pcb_length + 2*case_thickness/2,
                pcb_width + 2*case_thickness/2,
                case_thickness/2
            ]);
        }

        // pcb itself
        translate([-0.1, -0.1, -0.1])
        cube(size=[
            pcb_length + 0.2,
            pcb_width + 0.2,
            infinity
        ]);

        // pcb bottom parts
        translate([-0.1, -0.1, -pcb_bottom_parts_thickness])
        cube(size=[
            pcb_length - case_thickness,
            pcb_width + 0.2,
            infinity
        ]);

        // usb port cutout
        usb_port(1.05);

        // reset button cutout
        translate([reset_btn_offset[0]-0.2, reset_btn_offset[1]-0.2, reset_btn_offset[2]-0.1])
        cube(size=[
            reset_btn_length + 0.4,
            reset_btn_width + 0.2,
            infinity
        ]);
    }
}

module top_case() {
    top_case_height = display_offset[2] + display_thickness - pcb_thickness + case_thickness*0.6;

    difference() {
        union() {
            // main body
            translate([-case_thickness, -case_thickness, pcb_thickness + epsilon])
            cube(size=[
                pcb_length + 2*case_thickness,
                pcb_width + 2*case_thickness,
                top_case_height
            ]);
        }

        // inner cutout
        translate([-0.1, -0.1, -epsilon])
        cube(size=[
            pcb_length + 0.2,
            pcb_width + 0.2,
            pcb_thickness + usb_port_thickness - 1
        ]);

        translate([
            -case_thickness/2-0.1,
            -case_thickness/2-0.1,
            case_thickness/2 + pcb_thickness + 0.1 - infinity
        ])
        cube(size=[
            pcb_length + case_thickness + 0.2,
            pcb_width + case_thickness + 0.2,
            infinity
        ]);

        translate([-case_thickness-0.1, -case_thickness-0.1, -(pcb_bottom_parts_thickness + case_thickness-0.1)])
        cube(size=[
            pcb_length + 2*case_thickness + 0.2,
            pcb_width + 2*case_thickness + 0.2,
            pcb_bottom_parts_thickness + pcb_thickness + case_thickness
        ]);

        // display cutout
        display_hangover = 0.7;
        translate([
            display_offset[0] + display_hangover + 2,
            display_offset[1] + display_hangover,
            display_offset[2]])
        cube(size=[
            display_length - 2*display_hangover - 2,
            display_width - 2*display_hangover,
            50
        ]);

        // button cutouts
        translate(lower_push_btn_offset)
        scale([1.4, 1.3, 2])
        cylinder(r=push_btn_diameter/2, h=push_btn_height);

        translate(upper_push_btn_offset)
        scale([1.4, 1.3, 2])
        cylinder(r=push_btn_diameter/2, h=push_btn_height);

        // usb port cutout
        translate([-1.1, 0, 0.1]) usb_port(1.2);

        // reset button cutout
        translate([reset_btn_offset[0]-0.2, reset_btn_offset[1]-2, reset_btn_offset[2]-1.8])
        cube(size=[
            reset_btn_length + 0.4,
            reset_btn_width + 10,
            reset_btn_height + 2
        ]);
    }

    rails_height = top_case_height - 0.2;
    rails_z_offset = pcb_thickness + 0.1;

    // supportive rails behind USB port
    translate([usb_port_length, (pcb_width-case_thickness)/2, rails_z_offset])
    cube(size=[case_thickness, case_thickness, rails_height]);

    // supportive rails besides display
    translate([display_offset[0]+4, 1, rails_z_offset])
    cube(size=[display_length*0.8, case_thickness, rails_height]);
    translate([display_offset[0]+4, pcb_width-case_thickness-1, rails_z_offset])
    cube(size=[display_length*0.8, case_thickness, rails_height]);

    // supportive rails at the tail
    translate([pcb_length-4, case_thickness/2, rails_z_offset])
    cube(size=[case_thickness, pcb_width-case_thickness, rails_height]);
}


difference() {
    union() {
        translate([0, 0, 1])
        color("orange") top_case();
        translate([0, 0, -1])
        color("yellow", 1) bottom_case();

        color("green") pcb();
        color("blue") display();
        color("red") buttons();
        color("gray") usb_port();
    }

    // cross-cut
    // translate([-infinity/2, pcb_width/2-1, -infinity/2])
    // cube(size=[infinity, 2, infinity]);
    // translate([pcb_length/2-2, -infinity/2, -infinity/2])
    // cube(size=[4, infinity, infinity]);

    // translate([pcb_length/2, -infinity/2, -infinity/2])
    // cube(size=[infinity, infinity, infinity]);
    // translate([-infinity/2, pcb_width/2, -infinity/2])
    // cube(size=[infinity, infinity, infinity]);
}
