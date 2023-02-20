wall_thickness = 10 * 0.4;
echo(str("wall_thickness = ", wall_thickness));

$fn=50;

function num_or_zero (n) =
  n == undef ? 0 : n;

platform_diameter = 60;
height = 30;
diameters=[ for(d=[12,10,9,8,7,6]) d+wall_thickness/2 ];

// platform_diameter = 45;
// height = 20;
// diameters=[ for(d=[6,5,4,3,2,1]) d+wall_thickness/2 ];

zylinders=[
  for(i=[0:len(diameters)-1])
    if (i == 0)      [diameters[i], 0, 0]
    else if (i == 1) [diameters[i], 0.5*(diameters[0]+diameters[1]), 0]
    else let (
      a = 0.5*(diameters[0]+diameters[i-1]),
      b = 0.5*(diameters[i-1]+diameters[i]),
      c = 0.5*(diameters[0]+diameters[i]),
      beta = acos((a^2 + c^2 - b^2)/(2 * a * c)),
      x_offset = c,
      z_rot = beta
    ) [diameters[i], x_offset, z_rot]
];
zylinders_cum=[
  for(i=0, cum=0; i < len(zylinders); i=i+1, cum=cum + num_or_zero(zylinders[i][2]))
    if (i == 0) zylinders[i]
    else [
      zylinders[i][0],
      zylinders[i][1],
      cum
    ]
];

echo(zylinders_cum);

difference() {
    union() {
      translate([0, 0, -0.2])
      difference() {
        cylinder(d = platform_diameter, h = 2.4, center = false);

        for(zyl = zylinders_cum) {
          rotate([0,0,zyl[2]])
            translate([platform_diameter/2.5 - wall_thickness,0, 2.4])
              cube(size=[8, 0.8, 1], center=true);
          rotate([0,0,zyl[2]])
            translate([zyl[1],-platform_diameter/4, 2.4])
              cube(size=[0.8, 8, 1], center=true);
        }
      }

      for(zyl = zylinders_cum) {
        rotate([0,0,zyl[2]])
          translate([zyl[1], 0, 0])
            cylinder(d = zyl[0]+wall_thickness/2, h = height, center = false);
      }
    }

    translate([0,0,-2.2])
    union() {
      for(zyl = zylinders_cum) {
        // drill holes
        rotate([0,0,zyl[2]])
          translate([zyl[1], 0, 0])
            cylinder(d = zyl[0]-wall_thickness/2+0.3, h = 4*height, center = false);

        // thick angle marks
        rotate([0,0,zyl[2]])
          translate([platform_diameter/2 - wall_thickness, 0, 0])
            cube(size=[4, 1.6, 10], center=true);

        // slim angle marks (+90 deg)
        rotate([0,0,zyl[2]])
          translate([zyl[1],-platform_diameter/3, 0])
            cube(size=[0.8, 3, 10], center=true);
      }
    }
}

