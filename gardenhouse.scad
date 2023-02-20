$fn=150;

roof_widht_overlap = 80;
roof_widht_overlap_shift = -60;
roof_length_overlap = 100;
roof_length_overlap_shift = -60;
roof_slope = 7; // degrees

length = 600;
width = 300;
front_h = 250;
back_h = front_h - width*tan(roof_slope); //216;

base_w = 30;
base_h = 10;

// timber sizes
floor_timber_w = 8;
floor_timber_h = 12;
fat_timber_w = 6;
fat_timber_h = 12;
flat_timber_w = 2.8;
flat_timber_h = 20;
slim_timber_w = 6;
slim_timber_h = 4;

module xz_frame(timber_dim, inner_box) {
    translate([timber_dim[0], 0, timber_dim[1]])
    difference() {
        translate([-timber_dim[0], 0, -timber_dim[1]])
        cube([
            inner_box[0] + 2*timber_dim[0],
            inner_box[1],
            inner_box[2] + 2*timber_dim[1]
        ]);

        translate([0,-1,0])
        cube([
            inner_box[0],
            inner_box[1]+2,
            inner_box[2]
        ]);
    }
}


module yz_frame(timber_dim, inner_box) {
    translate([0, timber_dim[0], timber_dim[1]])
    difference() {
        translate([0, -timber_dim[0], -timber_dim[1]])
        cube([
            inner_box[1],
            inner_box[0] + 2*timber_dim[0],
            inner_box[2] + 2*timber_dim[1]
        ]);

        translate([-1,0,0])
        cube([
            inner_box[1]+2,
            inner_box[0],
            inner_box[2]
        ]);
    }
}

// base and floor
#union() {
    floor_segments_x = 8;
    floor_segments_y = 2;
    floor_segment_length = (length-floor_timber_w)/floor_segments_x;
    floor_segment_width = (width-floor_timber_w)/floor_segments_y;

    for (y = [0:2:floor_segments_y])
    for (x = [0:2:floor_segments_x]) {
        translate([
            x*floor_segment_length - (base_w - floor_timber_w)/2,
            y*floor_segment_width - (base_w - floor_timber_w)/2,
            -base_h])
        cube(size=[base_w,base_w,base_h]);
    }

    for (y = [1:2:floor_segments_y])
    for (x = [1:2:floor_segments_x]) {
        translate([
            x*floor_segment_length - (base_w - floor_timber_w)/2,
            y*floor_segment_width - (base_w - floor_timber_w)/2,
            -base_h])
        cube(size=[base_w,base_w,base_h]);
    }

    // ground
    for (y = [0:floor_segments_y]) {
        translate([0, y*floor_segment_width, 0])
        cube(size=[length, floor_timber_w, floor_timber_h]);
    }
    for (x = [0:floor_segments_x]) {
        translate([x*floor_segment_length,0,0])
        cube(size=[floor_timber_w, width, floor_timber_h]);
    }
}

// back
union() {
    back_fat_segments = 4;
    back_fat_segment_l = (length-fat_timber_h)/back_fat_segments;

    back_slim_segments = 3;
    back_slim_segment_l = back_fat_segment_l;

    // bottom timber
    color([0.5, 0.9, 0.9])
    translate([0, width-slim_timber_w, floor_timber_h])
    cube([length, slim_timber_w, slim_timber_h]);

    // vertical fat timbers
    for (x = [0:back_fat_segments]) {
        color([0.6, 0.8, 0.9])
        translate([
            x*back_fat_segment_l,
            width - fat_timber_w,
            floor_timber_h + slim_timber_h])
        cube([fat_timber_h, fat_timber_w, back_h - fat_timber_h - slim_timber_h]);
    }

    // vertical slim timbers
    for (x = [0:back_slim_segments]) {
        color([0.7, 0.8, 0.7])
        translate([
            back_fat_segment_l + slim_timber_h + (x-.5)*back_slim_segment_l,
            width - slim_timber_w,
            floor_timber_h + slim_timber_h])
        cube([
            slim_timber_h,
            slim_timber_w,
            back_h - fat_timber_h - slim_timber_h]);
    }

    // top timber
    color([0.7, 0.7, 0.9])
    translate([roof_length_overlap_shift-roof_length_overlap, width-fat_timber_w, floor_timber_h + back_h - fat_timber_h])
    cube(size=[length + 2*roof_length_overlap, fat_timber_w, fat_timber_h]);
}

// left wall
difference() {
    left_fat_segments = 2;
    left_fat_segment_l = (width-fat_timber_h-2*fat_timber_w)/left_fat_segments;

    left_slim_segments = 1;
    left_slim_segment_l = (width-slim_timber_h-2*slim_timber_w)/(left_slim_segments+1);

    door_w = 108 + 2;
    door_h = 198 + 2;

    wnd_w = 100;
    wnd_h = 120;
    wnd_y = door_h - wnd_h;

    union() {
        // bottom timber
        color([0.5, 0.9, 0.9])
        translate([0, fat_timber_w, floor_timber_h])
        cube([slim_timber_w, width - 2*fat_timber_w, slim_timber_h]);

        // vertical fat timbers
        for (x = [0:left_fat_segments]) {
            color([0.6, 0.8, 0.9])
            translate([
                0,
                fat_timber_w + x*left_fat_segment_l,
                floor_timber_h + slim_timber_h])
            cube([
                fat_timber_w,
                fat_timber_h,
                front_h - 2*slim_timber_h - ((front_h - slim_timber_h - back_h) * x / left_fat_segments)
            ]);
        }

        // vertical slim timbers
        for (x = [0:left_slim_segments]) {
            color([0.7, 0.8, 0.7])
            translate([
                0,
                fat_timber_w + left_fat_segment_l + slim_timber_h + (x-0.5)*left_slim_segment_l,
                floor_timber_h + slim_timber_h])
            cube([
                slim_timber_w,
                slim_timber_h,
                front_h - 2*slim_timber_h - ((front_h - slim_timber_h - back_h) * (x+0.5) / left_fat_segments)
            ]);
        }

        // top timber
        color([0.7, 0.7, 0.9])
        translate([0, 0, floor_timber_h + front_h - slim_timber_h])
        rotate([-roof_slope])
        translate([0, fat_timber_w, 0])
        cube(size=[slim_timber_w, (width - 2*fat_timber_w)/cos(roof_slope), slim_timber_h]);

        // left window
        union() {
            translate([
                0,
                fat_timber_w + 1.5*left_fat_segment_l + fat_timber_h/2 - slim_timber_h - wnd_w/2,
                floor_timber_h + wnd_y]
            )
            yz_frame(
                [slim_timber_h, slim_timber_h],
                [wnd_w, slim_timber_w, wnd_h]
            );

            translate([
                0,
                fat_timber_w + fat_timber_h/2 + left_fat_segment_l,
                wnd_y + floor_timber_h])
            cube([slim_timber_w, left_fat_segment_l, slim_timber_h]);
        }

        // door
        union() {
            translate([
                0,
                fat_timber_w + left_fat_segment_l - door_w - (fat_timber_h+slim_timber_h)/2,
                floor_timber_h
            ])
            yz_frame(
                [slim_timber_h, slim_timber_h],
                [door_w, slim_timber_w, door_h]
            );
        }

        // door/wnd top timber
        translate([0, fat_timber_w + fat_timber_h/2, floor_timber_h + slim_timber_h + door_h])
        cube([slim_timber_w, 2*left_fat_segment_l, slim_timber_h]);
    }

    // left window intersection
    translate([
        -1,
        fat_timber_w + 1.5*left_fat_segment_l + fat_timber_h/2 - wnd_w/2,
        floor_timber_h + slim_timber_h + wnd_y
    ])
    cube([2*slim_timber_w, wnd_w, wnd_h]);

    // door intersection
    translate([
        -1,
        fat_timber_w + left_fat_segment_l - door_w - (fat_timber_h-slim_timber_h)/2,
        floor_timber_h + slim_timber_h
    ])
    cube([2*slim_timber_w, door_w, door_h]);
}

// front
difference() {
    front_fat_segments = 4;
    front_fat_segment_l = (length-fat_timber_h)/front_fat_segments;

    front_slim_segments = 3;
    front_slim_segment_l = front_fat_segment_l;

    door_w = 98 + 2;
    door_h = 198 + 2;

    wnd_w = 100;
    wnd_h = 120;
    wnd_y = door_h - wnd_h;

    union() {
        // bottom timber
        color([0.5, 0.9, 0.9])
        translate([0, 0, floor_timber_h])
        cube([length, slim_timber_w, slim_timber_h]);

        // vertical fat timbers
        for (x = [0:front_fat_segments]) {
            color([0.6, 0.8, 0.9])
            translate([
                x*front_fat_segment_l,
                0,
                floor_timber_h + slim_timber_h])
            cube([fat_timber_h, fat_timber_w, front_h - fat_timber_h - slim_timber_h]);
        }

        // vertical slim timbers
        for (x = [0:front_slim_segments]) {
            color([0.7, 0.8, 0.7])
            translate([
                front_fat_segment_l + slim_timber_h + (x-.5)*front_slim_segment_l,
                0,
                floor_timber_h + slim_timber_h])
            cube([
                slim_timber_h,
                slim_timber_w,
                front_h - fat_timber_h - slim_timber_h]);
        }

        // top timber
        color([0.7, 0.7, 0.9])
        translate([roof_length_overlap_shift-roof_length_overlap, 0, floor_timber_h + front_h - fat_timber_h])
        cube(size=[length + 2*roof_length_overlap, fat_timber_w, fat_timber_h]);

        // left window
        union() {
            translate([
                0.5*front_fat_segment_l + fat_timber_h/2 - slim_timber_h - wnd_w/2,
                0,
                floor_timber_h + wnd_y]
            )
            xz_frame(
                [slim_timber_h, slim_timber_h],
                [wnd_w, slim_timber_w, wnd_h]
            );

            translate([
                fat_timber_h/2,
                0,
                wnd_y + floor_timber_h])
            cube([front_fat_segment_l, slim_timber_w, slim_timber_h]);
        }

        // door
        union() {
            translate([
                1.5*front_fat_segment_l + fat_timber_h/2 - slim_timber_h - door_w/2,
                0,
                floor_timber_h
            ])
            xz_frame(
                [slim_timber_h, slim_timber_h],
                [door_w, slim_timber_w, door_h]
            );
        }

        // right window
        union() {
            translate([
                2.5*front_fat_segment_l + fat_timber_h/2 - slim_timber_h - wnd_w/2,
                0,
                floor_timber_h + wnd_y]
            )
            xz_frame(
                [slim_timber_h, slim_timber_h],
                [wnd_w, slim_timber_w, wnd_h]
            );

            translate([
                2*front_fat_segment_l + fat_timber_h/2,
                0,
                wnd_y + floor_timber_h])
            cube([front_fat_segment_l, slim_timber_w, slim_timber_h]);
        }

        // door/wnd top timber
        translate([fat_timber_h/2, 0, floor_timber_h + slim_timber_h + door_h])
        cube([3*front_fat_segment_l, slim_timber_w, slim_timber_h]);
    }

    // left window intersection
    translate([
        0.5*front_fat_segment_l + fat_timber_h/2 - wnd_w/2,
        -1,
        floor_timber_h + slim_timber_h + wnd_y
    ])
    cube([wnd_w, 2*slim_timber_w, wnd_h]);

    // door intersection
    translate([
        1.5*front_fat_segment_l + fat_timber_h/2 - door_w/2,
        -1,
        floor_timber_h + slim_timber_h
    ])
    cube([door_w, 2*slim_timber_w, door_h]);

    // right window intersection
    translate([
        2.5*front_fat_segment_l + fat_timber_h/2 - wnd_w/2,
        -1,
        floor_timber_h + slim_timber_h + wnd_y
    ])
    cube([wnd_w, 2*slim_timber_w, wnd_h]);
}

// right wall
difference() {
    right_fat_segments = 2;
    right_fat_segment_l = (width-fat_timber_h-2*fat_timber_w)/right_fat_segments;

    right_slim_segments = 1;
    right_slim_segment_l = (width-slim_timber_h-2*slim_timber_w)/(right_slim_segments+1);

    door_w = 98 + 2;
    door_h = 198 + 2;

    wnd_w = 100;
    wnd_h = 120;
    wnd_y = door_h - wnd_h;

    union() {
        // bottom timber
        color([0.5, 0.9, 0.9])
        translate([length - fat_timber_w, fat_timber_w, floor_timber_h])
        cube([slim_timber_w, width - 2*fat_timber_w, slim_timber_h]);

        // vertical fat timbers
        for (x = [0:right_fat_segments]) {
            color([0.6, 0.8, 0.9])
            translate([
                length - fat_timber_w,
                fat_timber_w + x*right_fat_segment_l,
                floor_timber_h + slim_timber_h])
            cube([
                fat_timber_w,
                fat_timber_h,
                front_h - 2*slim_timber_h - ((front_h - slim_timber_h - back_h) * x / right_fat_segments)
            ]);
        }

        // vertical slim timbers
        for (x = [0:right_slim_segments]) {
            color([0.7, 0.8, 0.7])
            translate([
                length - fat_timber_w,
                fat_timber_w + right_fat_segment_l + slim_timber_h + (x-0.5)*right_slim_segment_l,
                floor_timber_h + slim_timber_h])
            cube([
                slim_timber_w,
                slim_timber_h,
                front_h - 2*slim_timber_h - ((front_h - slim_timber_h - back_h) * (x+0.5) / right_fat_segments)
            ]);
        }

        // top timber
        color([0.7, 0.7, 0.9])
        translate([length - fat_timber_w, 0, floor_timber_h + front_h - slim_timber_h])
        rotate([-roof_slope])
        translate([0, fat_timber_w, 0])
        cube(size=[slim_timber_w, (width - 2*fat_timber_w)/cos(roof_slope), slim_timber_h]);
    }
}

// roof
difference() {
    roof_fat_segments = 8;
    roof_fat_segment_l = (length + roof_length_overlap - fat_timber_w)/roof_fat_segments;
    roof_fat_segment_l = (length + 2*roof_length_overlap - fat_timber_w)/roof_fat_segments;

    union() {
        translate([0, 0, floor_timber_h + front_h])
        rotate([-roof_slope])
        union() {
            for (x = [0:roof_fat_segments]) {
                translate([
                    x*roof_fat_segment_l + roof_length_overlap_shift - roof_length_overlap,
                    roof_widht_overlap_shift - roof_widht_overlap,
                    0
                ])
                cube(size=[slim_timber_w, width + 2*roof_widht_overlap, fat_timber_h]);
            }

            // // left plank
            // translate([
            //     roof_length_overlap_shift - roof_length_overlap,
            //     roof_widht_overlap_shift - roof_widht_overlap,
            //     0
            // ])
            // cube(size=[slim_timber_w, width + 2*roof_widht_overlap, fat_timber_h]);

            // // right plank
            // translate([
            //     roof_fat_segments*roof_fat_segment_l + roof_length_overlap_shift + roof_length_overlap,
            //     roof_widht_overlap_shift - roof_widht_overlap,
            //     0
            // ])
            // cube(size=[slim_timber_w, width + 2*roof_widht_overlap, fat_timber_h]);

            // front facade
            translate([
                roof_length_overlap_shift - roof_length_overlap,
                roof_widht_overlap_shift - roof_widht_overlap - flat_timber_w,
                flat_timber_h
            ])
            rotate([roof_slope])
            translate([0,0,-flat_timber_h])
            cube(size=[length + 2*roof_length_overlap, flat_timber_w, flat_timber_h]);

            // back facade
            translate([
                roof_length_overlap_shift - roof_length_overlap,
                width + roof_widht_overlap_shift + roof_widht_overlap - flat_timber_w,
                flat_timber_h
            ])
            rotate([roof_slope])
            translate([0,0,-flat_timber_h])
            cube(size=[length + 2*roof_length_overlap, flat_timber_w, flat_timber_h]);
        }
    }

}