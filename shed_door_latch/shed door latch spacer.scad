z = 3/4;
x = 0.9; //was 7/8
y = 1/2 - 3/32;
rod = 3/8;
rod_clearance = 1/8;

_rod_hole = rod + rod_clearance;

difference(){
  union(){
    cube([x,y,z]);
    translate([0,y,z/2]){
      rotate(a=[0,90,0]){
        cylinder(h=x, r=z/2, center=false, $fn=180);
      }
    }
  }
  translate([0,(y+z/2) - rod/2, z/2]){
    rotate(a=[0,90,0]){
      cylinder(h=x, r=_rod_hole/2, center=false, $fn=180);
    }
  }
}