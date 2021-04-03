// pipe diameter
pipe = inch(1/2);

// bearing dimensions
bearing_id = inch(3/8);
bearing_od = inch(7/8);
bearing_width = inch(9/32);

// lip might be increased to maintain bearing space
pulley_od = inch(3);
pulley_lip = inch(1/32);

// how much pipe to wrap around
// max sane overlap is 0.50 == 50%
pipe_overlap_multiplier = 0.40;

/*
 * end user-modifiable vars
 */
 
// pulley width
pipe_segment = sqrt(
  (pipe*pipe_overlap_multiplier)*
  (pipe*(1-pipe_overlap_multiplier))
  ) * 2;
tpw = pipe_segment + (2 * pulley_lip);
min_pulley_width = 2 * bearing_width;
pulley_width = tpw < min_pulley_width
  ? min_pulley_width
  : tpw;

// bearing separator flange thickness
tbf = pulley_width - (2*bearing_width);
bearing_flange = tbf < 0
  ? 0
  : tbf;

// Check for safe pulley OD
// note: requires OpenSCAD > 2019.05
mpod = bearing_od + (2 * pipe * pipe_overlap_multiplier);
echo("Minimum pulley OD ",mpod / inch(1));
assert( pulley_od > mpod, "pulley OD < minimum");

rotate_extrude($fn=365){
  difference(){
    polygon( points=[
      [bearing_od/2,0],
      [bearing_od/2,bearing_width],
      [bearing_id/2,bearing_width],
      [bearing_id/2,bearing_width+bearing_flange],
      [bearing_od/2,bearing_width+bearing_flange],
      [bearing_od/2,pulley_width],
      [pulley_od/2,pulley_width],
      [pulley_od/2,0],
      [bearing_od/2,0]
    ]);
    translate([
      ((pulley_od/2)+(pipe/2)-(pipe*pipe_overlap_multiplier)),
      pulley_width/2,
      0
      ]){
      circle(pipe/2, $fn=365);
    }
  }
}

function inch(x) = 25.40 * x;