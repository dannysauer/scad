cube_height = 10;
bridge_length = 25;
bridge_thickness = 1.5;
union(){
    translate([bridge_length/2,0,cube_height/2])
      cube(cube_height, center=true);
    translate([-1*bridge_length/2,0,cube_height/2])
      cube(cube_height, center=true);
    translate([0,0,cube_height-(bridge_thickness/2)])
      cube([bridge_length,
            cube_height,
            bridge_thickness],
           center=true);
};