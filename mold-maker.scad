mold_width = 96;
mold_height = 40;
mold_length = 90;

cut_z_offset = -6;

mounting_hole_diameter = 4;

mounting_hole_1_x = mold_width/2 - mounting_hole_diameter/2 - 8;
mounting_hole_1_y = 0;
mounting_hole_1_z = -1*(cut_z_offset);

mounting_hole_2_x = -1*(mold_width/2 - mounting_hole_diameter/2 - 2);
mounting_hole_2_y = mold_length/2 - mounting_hole_diameter/2 - 2;
mounting_hole_2_z = -1*(cut_z_offset);

mounting_hole_3_x = -1*(mold_width/2 - mounting_hole_diameter/2 - 2);
mounting_hole_3_y = -1*(mold_length/2 - mounting_hole_diameter/2 - 2);
mounting_hole_3_z = -1*(cut_z_offset);

bottom_half_cut_x_offset = 17;

bottom_half_reg_hole_1_x = bottom_half_cut_x_offset;
bottom_half_reg_hole_1_y = 41;
bottom_half_reg_hole_1_z = -16;

bottom_half_reg_hole_2_x = bottom_half_cut_x_offset;
bottom_half_reg_hole_2_y = -1*bottom_half_reg_hole_1_y;
bottom_half_reg_hole_2_z = bottom_half_reg_hole_1_z;


bottom_half_cut_x_half_cut_x_offset = -24;

bottom_half_half_reg_hole_1_x = bottom_half_cut_x_offset + bottom_half_cut_x_half_cut_x_offset;
bottom_half_half_reg_hole_1_y = 15;
bottom_half_half_reg_hole_1_z = -10;

bottom_half_half_reg_hole_2_x = bottom_half_cut_x_offset + bottom_half_cut_x_half_cut_x_offset;
bottom_half_half_reg_hole_2_y = -1*bottom_half_half_reg_hole_1_y;
bottom_half_half_reg_hole_2_z = bottom_half_half_reg_hole_1_z;


mounting_hole_female_extra_diameter = 2;


pour_hole_diameter = 15;
pour_hole_length = 5;
//pour_hole_z = -15;



module whole_mold(){
    difference(){
        cube([mold_width,mold_length, mold_height], center=true);
        translate([-18,3,-19]) import("low_poly_cat_v3 - no holes.stl");
//        translate([-1*(mold_width/2 + 1),0,pour_hole_z]) rotate([0,90,0]) cylinder(h=pour_hole_length, d=pour_hole_diameter);
    }
}


module bottom_half(){
    removal_block_height = mold_height;
    difference(){
        whole_mold();
        translate([0,0,removal_block_height/2 - cut_z_offset]) cube([mold_width + 1, mold_length + 1, removal_block_height], center=true);
        translate([-1*(mold_width/2 + 1),0,-1*(cut_z_offset/2)]) rotate([0,90,0]) cylinder(h=pour_hole_length, d=pour_hole_diameter);

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
    translate([-1*(mold_width/2 + 1),0,-1*(cut_z_offset/2)]) rotate([0,90,0]) cylinder(h=pour_hole_length, d=pour_hole_diameter);


    }
    

}


module bottom_half_neg_x(){
    // split along y axis
    difference(){
        bottom_half();
        translate([mold_width/4 + bottom_half_cut_x_offset,0,-1]) cube([mold_width/2, mold_length + 4, mold_height], center=true);
    }

    translate([bottom_half_reg_hole_1_x, bottom_half_reg_hole_1_y, bottom_half_reg_hole_1_z]) sphere(d=mounting_hole_diameter);
    translate([bottom_half_reg_hole_2_x, bottom_half_reg_hole_2_y, bottom_half_reg_hole_2_z]) sphere(d=mounting_hole_diameter);

}

module bottom_half_pos_x(){
    // split along y axis
    x_size = mold_width/2 + 30;
    difference(){
        bottom_half();
        translate([-1*(x_size/2 - bottom_half_cut_x_offset),0,-1]) cube([x_size, mold_length + 4, mold_height], center=true);
        translate([bottom_half_reg_hole_1_x, bottom_half_reg_hole_1_y, bottom_half_reg_hole_1_z]) sphere(d=mounting_hole_diameter + mounting_hole_female_extra_diameter);
        translate([bottom_half_reg_hole_2_x, bottom_half_reg_hole_2_y, bottom_half_reg_hole_2_z]) sphere(d=mounting_hole_diameter + mounting_hole_female_extra_diameter);
    }

    

}


module bottom_half_neg_x_half_neg_x(){
    difference(){
        bottom_half_neg_x();
        translate([mold_width/4 + bottom_half_cut_x_offset + bottom_half_cut_x_half_cut_x_offset,0,-1]) cube([mold_width/2, mold_length + 4, mold_height], center=true);

    }
    
    translate([bottom_half_half_reg_hole_1_x, bottom_half_half_reg_hole_1_y, bottom_half_half_reg_hole_1_z]) sphere(d=mounting_hole_diameter);
    translate([bottom_half_half_reg_hole_2_x, bottom_half_half_reg_hole_2_y, bottom_half_half_reg_hole_2_z]) sphere(d=mounting_hole_diameter);
    
}

//bottom_half_neg_x_half_neg_x();

module bottom_half_neg_x_half_pos_x(){
    x_size = mold_width/2 + 30;
    difference(){
        bottom_half_neg_x();
        translate([-1*(x_size/2 - bottom_half_cut_x_offset - bottom_half_cut_x_half_cut_x_offset),0,-1]) cube([x_size, mold_length + 4, mold_height], center=true);

        translate([bottom_half_half_reg_hole_1_x, bottom_half_half_reg_hole_1_y, bottom_half_half_reg_hole_1_z]) sphere(d=mounting_hole_diameter);
        translate([bottom_half_half_reg_hole_2_x, bottom_half_half_reg_hole_2_y, bottom_half_half_reg_hole_2_z]) sphere(d=mounting_hole_diameter);
    }
    
}




//
//difference(){
//    bottom_half();
//    translate([-1*(mold_width/4),0,-1]) cube([mold_width/2, mold_length + 4, mold_height], center=true);
//}


// split along x axis
//difference(){
//    bottom_half();
//    translate([0,mold_length/4 + 1,-1]) cube([mold_width + 2, mold_length/2 + 2, mold_height], center=true);
//}

//translate([0,mold_length + 10,mold_height/2]) bottom_half();



//
translate([-30,mold_length + 10,mold_height/2]) bottom_half_neg_x_half_neg_x();
translate([-10,mold_length + 10,mold_height/2]) bottom_half_neg_x_half_pos_x();

translate([10,mold_length + 10,mold_height/2]) bottom_half_pos_x();
translate([0,0,mold_height/2]) rotate([0,180,180]) top_half();