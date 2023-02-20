// height of baseplate
hbp=2.7;

// hexagonal diameter
dh=30;
lh=tan(30)*dh;echo(radius=lh);

// width
w=6;
// base plate width
wbp=3*w*lh; echo(width=wbp);

// length
l=5;
// base plate length
lbp=2*l*dh; echo(length=lbp);

// minkowski radius
mr=2;

// nozzle width
wn=0.4;

difference()
{
    union()
    {
        color("Silver")
        cube([wbp,lbp,hbp]);

        color("Blue")
        for(xx=[0:w/2-1])
        {
            translate([lh+lh/2+xx*lh*6,lbp-4-mr,0])
            minkowski()
            {
                scale([1,2,1])
                rotate([0,0,30])
                cylinder(h=hbp-1,d=20,$fn=3);
                cylinder(h=1,r=mr,$fn=30);
            };
        };

        color("LightBlue")
        for(xx=[0:w/2-2])
        {
            translate([6,dh*3+xx*4*dh,0])
            minkowski()
            {
                scale([2,1,1])
                rotate([0,0,120])
                cylinder(h=hbp-1,d=20,$fn=3);
                cylinder(h=1,r=mr,$fn=30);
            };
        };
    };

    color("Green")
    for(x=[0:w-1])
    {
        for(y=[0:l])
        {
            if(floor(x/2)==x/2)
                translate([lh+lh/2+3*x*lh,dh+2*y*dh,-hbp/2])
                cylinder(h=2*hbp,d=2*lh,$fn=6);
            else
                translate([lh+lh/2+3*x*lh,2*y*dh,-hbp/2])
                cylinder(h=2*hbp,d=2*lh,$fn=6);

        };
    };

    color("Orange")
    for(xx=[0:w/2-1])
    {
        translate([lh+lh/2+xx*lh*6,-4-mr,-hbp/2])
        minkowski()
        {
            scale([1,2,1])
            rotate([0,0,30])
            cylinder(h=2*hbp,d=20,$fn=3);
            cylinder(h=1,r=mr+wn/2,$fn=30);
        };
    };

    color("Red")
    for(xx=[0:w/2-2])
    {
        translate([wbp+6,dh*3+xx*4*dh,-hbp/2])
        minkowski()
        {
            scale([2,1,1])
            rotate([0,0,120])
            cylinder(h=2*hbp,d=20,$fn=3);
            cylinder(h=1,r=mr+wn/2,$fn=30);
        };
    };


};


