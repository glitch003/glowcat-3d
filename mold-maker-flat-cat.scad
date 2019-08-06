mold_width = 100;
mold_height = 35;
mold_length = 100;

cut_z_offset = 11;

mounting_hole_diameter = 10;

mounting_hole_1_x = mold_width/2 - mounting_hole_diameter/2 - 5;
mounting_hole_1_y = 0;
mounting_hole_1_z = -1*(cut_z_offset);

mounting_hole_2_x = -1*(mold_width/2 - mounting_hole_diameter/2 - 5);
mounting_hole_2_y = mold_length/2 - mounting_hole_diameter/2 - 3;
mounting_hole_2_z = -1*(cut_z_offset);

mounting_hole_3_x = -1*(mold_width/2 - mounting_hole_diameter/2 - 5);
mounting_hole_3_y = -1*(mold_length/2 - mounting_hole_diameter/2 - 3);
mounting_hole_3_z = -1*(cut_z_offset);

mounting_hole_female_extra_diameter = 2;


pour_hole_diameter = 12;
pour_hole_length = 5;
pour_hole_z = 0;

flatcat_height = 30;




module whole_mold(){
    difference(){
        cube([mold_width,mold_length, mold_height], center=true);
        rotate([0,0,-90]) translate([0,0,-1*flatcat_height/2]) import("flatcat.stl");
//        translate([-1*(mold_width/2 + 1),0,pour_hole_z]) rotate([0,90,0]) cylinder(h=pour_hole_length, d=pour_hole_diameter);
    }
}

module bottom_half(){
    removal_block_height = mold_height;
    difference(){
        whole_mold();
        translate([0,0,removal_block_height/2 - cut_z_offset]) cube([mold_width + 1, mold_length + 1, removal_block_height], center=true);
        translate([-1*(mold_width/2 + 1),0,-1*cut_z_offset]) rotate([0,90,0]) cylinder(h=pour_hole_length, d=pour_hole_diameter);

    }
    translate([mounting_hole_1_x,mounting_hole_1_y,mounting_hole_1_z]) sphere(d=mounting_hole_diameter);
    translate([mounting_hole_2_x,mounting_hole_2_y,mounting_hole_2_z]) sphere(d=mounting_hole_diameter);
    translate([mounting_hole_3_x,mounting_hole_3_y,mounting_hole_3_z]) sphere(d=mounting_hole_diameter);

}


module top_half(){
    removal_block_height = mold_height;
    difference(){
        whole_mold();
        translate([0,0,-1*(removal_block_height/2 + cut_z_offset)]) cube([mold_width + 1, mold_length + 1, removal_block_height], center=true);
        translate([mounting_hole_1_x,mounting_hole_1_y,mounting_hole_1_z]) sphere(d=mounting_hole_diameter + mounting_hole_female_extra_diameter);
        translate([mounting_hole_2_x,mounting_hole_2_y,mounting_hole_2_z]) sphere(d=mounting_hole_diameter + mounting_hole_female_extra_diameter);
        translate([mounting_hole_3_x,mounting_hole_3_y,mounting_hole_3_z]) sphere(d=mounting_hole_diameter + mounting_hole_female_extra_diameter);
    translate([-1*(mold_width/2 + 1),0,-1*cut_z_offset]) rotate([0,90,0]) cylinder(h=pour_hole_length, d=pour_hole_diameter);


    }
    

}

// split along y axis
difference(){
    top_half();
    translate([mold_width/4 + 1,0,0]) cube([mold_width/2 + 1, mold_length + 4, mold_height+1], center=true);
}

// split along x axis
//difference(){
//    bottom_half();
//    translate([0,mold_length/4 + 1,-1]) cube([mold_width + 2, mold_length/2 + 2, mold_height], center=true);
//}

//translate([0,mold_length + 10,mold_height/2]) bottom_half();
//translate([0,0,mold_height/2]) rotate([0,180,180]) top_half();