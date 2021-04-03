/*
 Tool to open Beths mecine bottle
*/
include <MCAD/units.scad>
use <MCAD/libtriangles.scad>

neck_diameter = 0.46*inch;
height = (0.11 + .05)*inch;
base = 1*inch;

module lever(neck, w, h){
    box_length = 1.5*inch;
    union(){
        translate([box_length/2,0,0]){
            _wedge(neck, w, h);
        }
        _box(box_length, w, h, neck);
        translate([-1*box_length/2,0,0]){
            _hook(w, h);
        }
    }
}

module _wedge(neck, w, h){
    _real_wedge(neck,w,h);
    mirror(Y)
      _real_wedge(neck,w,h);
}

module _real_wedge(n,w,h){
    ww = (w-n)/2;
    translate([0, n/2, 0])
        rightprism(w,ww,h);
}

module _box(l, w, h, n){
    linear_extrude(h){
        difference(){
            square(size=[l,w], center=true);
            union(){
                circle(n/2);
                translate([l/4,0,0])
                    square(size=[l/2,n], center=true);
            }
        }
    }
}

module _hook(w, h){
    t=h*1.25;
    linear_extrude(h){
        union(){
            // curved base
            intersection(){
                circle(w/2, center=true);
                translate([-1*w/2,0,0])
                    square(size=[w,w], center=true);
            }
            // hook top
            translate([-1*(w-t),0,0]){
                // vertical filler below hook
                difference(){
                    square(size=[w,w/2], center=false);
                    circle((w/2)-t, center=true);
                }
                // top of hook
                difference(){
                    intersection(){
                        circle(w/2, center=true);
                        translate([-1*w/2,0,0])
                            square(size=[w,w], center=true);
                    }
                    circle((w/2)-t, center=true);
                }
                // curve at end of hook
                translate([0,-1*((w/2)-(t/2)),0])
                    circle(t/2, center=true);
            }
        }
    }
}

lever(neck_diameter, base, height,
      $fn=100);