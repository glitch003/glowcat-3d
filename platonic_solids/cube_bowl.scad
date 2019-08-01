
difference(){
    translate([0,0,-25]) cube([50,50,50], center=true);
    
    rotate([0,0,1], a=45) scale([1.05,0.85,1.9]) sphere(r=25);
//    rotate([0,0,1], a=135) scale([1.05,0.85,1.9]) sphere(r=25);
//    rotate([0,0,1], a=135) scale([1.2,0.6,1.9]) sphere(r=25);
}