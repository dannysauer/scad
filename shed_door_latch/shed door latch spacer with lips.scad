z = 3/4;
// x = 7/8; // about 1/32 too tight
x = 0.9;
y = 1/2 - 3/32;
rod=3/8;
rod_clearance = 1/8;
lip=1/16;

_lipz = z+2*lip;
_rod_hole = rod + rod_clearance;

intersection(){
  translate([-1*lip,0,-1*lip]){
    cube([x+2*lip, 11/16+1/32, z+2*lip]);
  }
difference(){
  union(){
    // middle
    cube([x,y,z]);
    translate([0,y,z/2]){
      rotate(a=[0,90,0]){
        cylinder(h=x, r=z/2, center=false, $fn=180);
      }
    }
    // right lip
    translate([-1*lip,0,-1*lip]){
      cube([lip,y,_lipz]);
      translate([0,y,_lipz/2]){
        rotate(a=[0,90,0]){
          cylinder(h=lip, r=_lipz/2, center=false, $fn=180);
        }
      }
    }
    // left lip
    translate([x,0,-1*lip]){
      cube([lip,y,_lipz]);
      translate([0,y,_lipz/2]){
        rotate(a=[0,90,0]){
          cylinder(h=lip, r=_lipz/2, center=false, $fn=180);
        }
      }
    }
  }
  // flatten back by subtracting a cube
  translate([-1*lip,-1*(y-_lipz/4),0]){
    cube([x+lip*2,y-_lipz/4,z]);
  }
  // lock pin hole
  translate([-1 * lip,(y+z/2) - rod/2, z/2]){
    rotate(a=[0,90,0]){
      cylinder(h=x+2*lip, r=_rod_hole/2, center=false, $fn=180);
    }
  }
}
}