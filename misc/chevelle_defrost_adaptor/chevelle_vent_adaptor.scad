include <Round-Anything/polyround.scad>

l = 5.25;
d = 2.35;
h = 3.75;

radius = 0.25;
thickness = 0.125;

duct_length = 1+thickness;
duct_diameter = 2.5

outerpoints = [
[0,0,radius],
[0,l,radius],
[d,l,radius],
[d,0,radius]
];

module box() {
    //polyRoundExtrude(outerpoints, h, radius, radius);
    extrudeWithRadius(h, r1=radius, r2=radius) polygon(polyRound(outerpoints, fn=5, mode=0));
}

module duct_inlet() {
    cylinder(duct_length, duct_diameter/2)
}

union(){
    
difference(){
  box();
  translate([thickness, thickness, thickness])
    resize([d-2*thickness, l-2*thickness, 0]) box();
};

translate([d-thickness, l/2-duct_diamater/2, 0])
duct_inlet();

}

/*subtract(
  {translate([thickness,thickness,thickness]);
  cube([w-2*thickness, d-2*thickness, h])},
  polyRoundExtrude(points, radius
  );
*/