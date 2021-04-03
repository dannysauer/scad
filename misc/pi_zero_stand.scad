plate_thickness = 2;
standoff_height = 2;
curve_precision = 50;

module pi(){
  cr = 3;
  x = 65;
  y = 30;
  translate([0, 0, plate_thickness/2])
  union(){
    // main plate
    cube([x-(2*cr),
          y-(2*cr),
          plate_thickness],
         center=true);

    // edges between corners
    translate([x/2 - cr/2, 0, 0])
    cube([cr,
          y-2*cr,
          plate_thickness],
         center=true);
    
    translate(-1*[x/2 - cr/2, 0, 0])
    cube([cr,
          y-2*cr,
          plate_thickness],
         center=true);
         
    translate([0, y/2 - cr/2, 0])
    cube([x-2*cr,
          cr,
          plate_thickness],
         center=true);

    translate(-1*[0, y/2 - cr/2, 0])
    cube([x-2*cr,
          cr,
          plate_thickness],
         center=true);

    // round corners
    translate([x/2-cr, y/2-cr, 0])
      cylinder(
        h=plate_thickness,
        r=cr,
        $fn=curve_precision,
        center=true);

    translate([-1*(x/2-cr), y/2-cr, 0])
      cylinder(
        h=plate_thickness,
        r=cr,
        $fn=curve_precision,
        center=true);
        
    translate([x/2-cr, -1*(y/2-cr), 0])
      cylinder(
        h=plate_thickness,
        r=cr,
        $fn=curve_precision,
        center=true);

    translate([-1*(x/2-cr), -1*(y/2-cr), 0])
      cylinder(
        h=plate_thickness,
        r=cr,
        $fn=curve_precision,
        center=true);        
  }
}

module standoff(){
  standoff_diameter = 6;
  peg_diameter = 2.75;
  peg_height = 1.6;
  union(){
    translate([0,0,standoff_height/2])
      color("blue")
      cylinder(
        h = standoff_height,
        r = standoff_diameter / 2,
        $fn=curve_precision,
        center=true
      );
    translate([0,0,standoff_height + peg_height/2]){
      color("red")
      cylinder(
        h = peg_height,
        r = peg_diameter / 2,
        $fn=curve_precision,
        center=true
      );
      // Z is already peg_height/2, so just go up peg_height (technically peg_height/2 + cap_height/2 if they weren't identical)
      translate([0,0,peg_height])
        color("green")
        cylinder(
          h = peg_height,
          r1=(peg_diameter+0.5) / 2,
          r2=peg_diameter / 2,
          $fn=curve_precision,
          center=true
        );
    }

  };
};

module standoffs(){
  x = 58 / 2;
  y = 23 / 2;
  //z = plate_thickness + standoff_height / 2;
  z = 0;
  translate([ 1*x,  1*y, z]) standoff(); 
  translate([-1*x,  1*y, z]) standoff(); 
  translate([ 1*x, -1*y, z]) standoff(); 
  translate([-1*x, -1*y, z]) standoff(); 
}

union(){
  pi();
  translate([0,0,plate_thickness])
    standoffs();
};