/*
 Tool to open Beth's mecine bottle
 
 Makes heavy use of linear extrude instead of cube/cylinder.  Deal with it.
*/
include <MCAD/units.scad>
use <MCAD/libtriangles.scad>

neck_diameter = 0.46*inch;
height = (0.11 + .05)*inch;
base = 1*inch;

module lever(neck, w, h){
    //box_length = 0.125*inch;
    box_length = neck/4; // this seems to work well
    union(){
        translate([box_length/2,0,0]){
            _wedge(neck, w, h);
        }
        linear_extrude(h){
          difference(){
            union(){
              _center_box(box_length, w);
              translate([-1*box_length/2,0,0]){
                  //_hook(w, h*1.5);
                  _hook(w, (w-neck)/2);
              }
            }
            _box_hole(box_length, neck, h);
          }
        }
    }
}

module _wedge(neck, w, h){
    intersection(){
        // round the tips off
        // 1.25 just looked pleasing to me
        linear_extrude(h)
            circle(d=1.25*w);
        union(){
            _real_wedge(neck,w,h);
            mirror(Y)
              _real_wedge(neck,w,h);
        }
    }
}

module _real_wedge(n,w,h){
    // w is overall width, but also length of wedges
    ww = (w-n)/2;
    translate([0, n/2, 0])
        rightprism(w,ww,h);
}

module _center_box(l, w){
  square(size=[l,w], center=true);
}

module _box_hole(box_length, diameter, h){
  hl=box_length/2; // half_length
  d=diameter;
  union(){
    circle(d=d);
    translate([hl/2,0,0])
        square(size=[hl,d], center=true);
  }
}

module _hook(w, thickness){
    t=thickness;
    union(){
        // curved base
        intersection(){
            circle(d=w);
            translate([-1*w/2,0,0])
                square(size=[w,w], center=true);
        }
        // hook top
        translate([-1*(w-t),0,0]){
            // vertical filler below hook
            difference(){
                square(size=[w-t,w/2], center=false);
                circle(r=(w/2)-t);
            }
            // top of hook
            difference(){
                intersection(){
                    circle(d=w);
                    translate([-1*w/2,0,0])
                        square(size=[w,w], center=true);
                }
                circle(r=(w/2)-t);
            }
            // curve at end of hook
            translate([0,-1*((w/2)-(t/2)),0])
                circle(d=t);
        }
    }
}

lever(neck_diameter, base, height,
      $fn=100);