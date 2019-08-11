total_internal_height = 1;
total_internal_width = 47;
total_internal_length = 55;

distance_from_edge = 3;

inner_d = 32;
outer_d = 43;


module ring(inner_diameter, outer_diameter){
    difference(){
        cylinder(d=outer_diameter, h=total_internal_height+1, center=true);
        cylinder(d=inner_diameter, h=total_internal_height+1, center=true);
    }
}

difference(){
    cube([total_internal_width,total_internal_length,total_internal_height], center=true);
    translate([0,total_internal_length/2 - outer_d/2 - distance_from_edge,0]) ring(inner_d,outer_d);
}

cube([1,50,total_internal_height], center=true);
rotate([0,0,90]) cube([1,45,total_internal_height], center=true);
rotate([0,0,112.5]) cube([1,49,total_internal_height], center=true);
rotate([0,0,-112.5]) cube([1,49,total_internal_height], center=true);
rotate([0,0,45]) cube([1,49,total_internal_height], center=true);
rotate([0,0,22.5]) cube([1,49,total_internal_height], center=true);
rotate([0,0,-45]) cube([1,49,total_internal_height], center=true);
rotate([0,0,-22.5]) cube([1,49,total_internal_height], center=true);