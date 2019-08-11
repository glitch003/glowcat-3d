$fn = 100;

wall_thickness = 1;


xenon_length = 52.2;

xenon_post_distance_apart_x = 18;
xenon_post_distance_apart_y = 46.4;
xenon_post_outer_diameter = 3.5;
xenon_post_inner_diameter = 1.5;
xenon_post_outer_height = 6;
xenon_post_inner_height = 1.9;
xenon_distance_from_wall_x = 12;
xenon_distance_from_wall_y = 2;

battery_length = 52.9;
battery_width = 33.5;
battery_thickness = 4.6;

wheel_outer_diameter = 45;

total_internal_height = 22;
total_internal_width = 45;
total_internal_length = 53;

extra_space_between_battery_and_xenon = 2.1;
    
battery_holder_flaps_thickness = xenon_post_outer_height + xenon_post_inner_height + extra_space_between_battery_and_xenon;
battery_holder_flaps_width = 10;
battery_holder_flaps_length = 30;
battery_holder_flaps_offset_y = 6;

space_between_battery_and_led_holder = 2;
    
led_holder_flaps_thickness = battery_thickness + space_between_battery_and_led_holder;
led_holder_flaps_width = 5.25;
led_holder_flaps_length = 30;

usb_hole_height = 3.5;
usb_hole_width = 8;
usb_hole_origin_z = 3.5;

button_post_diameter = 3;
button_post_height = 3.7;
button_post_distance_from_wall_x = 16.5;
button_post_distance_from_wall_y = 18;

window_size = 2;
window_distance_from_wall_x = 22;
window_distance_from_wall_y = button_post_distance_from_wall_y;

xenon_holder_length = 14;
xenon_holder_width = 2;
xenon_holder_height = 1;
xenon_holder_origin_z = 8.2;
xenon_holder_origin_x = battery_holder_flaps_width;
xenon_holder_origin_y = 18;

battery_top_holder_length = 18;
battery_top_holder_width = 2.5;
battery_top_holder_height = 1;
battery_top_holder_origin_z = led_holder_flaps_thickness + battery_holder_flaps_thickness - wall_thickness;
battery_top_holder_origin_x = led_holder_flaps_width;
battery_top_holder_origin_y = 28;

battery_slide_cutout_height = 20;
battery_slide_cutout_width = 42;
battery_slide_cutout_origin_y = -1 * (total_internal_length / 2);
battery_slide_cutout_origin_z = -1 * (total_internal_height / 2 - wall_thickness - battery_slide_cutout_height/2);
battery_slide_cutout_distance_from_bottom = 14;

reset_hole_diameter = 2;
reset_hole_distance_from_wall_x = 27;
reset_hole_distance_from_wall_y = button_post_distance_from_wall_y;

led_ring_antigravity_shelf_height = 5;
led_ring_antigravity_shelf_length = 1;
led_ring_antigravity_shelf_width = 3;
led_ring_antigravity_shelf_distance_from_top = 34;

led_ring_antigravity_shelf_top_height = 1;
led_ring_antigravity_shelf_top_length = 2;
led_ring_antigravity_shelf_top_width = 3;
led_ring_antigravity_shelf_top_distance_from_top = led_ring_antigravity_shelf_distance_from_top - 2;

led_ring_top_holder_height = 1;
led_ring_top_holder_length = 1.7;
led_ring_top_holder_width = 10;


lanyard_slot_height = 12;
lanyard_slot_length = wall_thickness * 2;
lanyard_slot_width = 4;
lanyard_slot_origin_z = 6;
lanyard_slot_origin_x = 6;





module main_enclosure(){
    difference(){
        cube([total_internal_width + wall_thickness*2, total_internal_length + wall_thickness*2,total_internal_height], center=true);
        
        // main inside of cube
        translate([0, 0, wall_thickness]) cube([total_internal_width, total_internal_length,total_internal_height], center=true);
        
        // y cutaway
//       translate([0, 0, wall_thickness]) cube([total_internal_width + wall_thickness, total_internal_length+10,total_internal_height], center=true);
        
        // x cutaway
//       translate([0, 0, wall_thickness]) cube([total_internal_width+10, total_internal_length + wall_thickness,total_internal_height], center=true);
        
        // usb hole
        translate([-1*(total_internal_width/2 - xenon_distance_from_wall_x - xenon_post_distance_apart_x/2 - xenon_post_outer_diameter/2),-1*total_internal_length / 2,-1*(total_internal_height/2 - usb_hole_height / 2 - wall_thickness - usb_hole_origin_z)]) cube([usb_hole_width, wall_thickness + 2, usb_hole_height], center=true);
        
        
        button_cutout();
        
        led_window();
        
        // battery slide cutout
        translate([0,battery_slide_cutout_origin_y,battery_slide_cutout_origin_z + battery_slide_cutout_distance_from_bottom]) cube([battery_slide_cutout_width, wall_thickness + 2, battery_slide_cutout_height], center=true);
        
        // reset hole
        translate([-1*(total_internal_width / 2 - wall_thickness - reset_hole_distance_from_wall_x), -1*(total_internal_length / 2 - wall_thickness - reset_hole_distance_from_wall_y) , -1*(total_internal_height/2 + wall_thickness/2)]) cylinder(d=reset_hole_diameter, h=wall_thickness * 2);
        
        // lanyard holes
        translate([-1*(total_internal_width/2 - lanyard_slot_width/2 - lanyard_slot_origin_x), total_internal_length/2 + wall_thickness/2, -1*(total_internal_height/2 - lanyard_slot_height/2 - lanyard_slot_origin_z)]) cube([lanyard_slot_width, lanyard_slot_length, lanyard_slot_height], center=true);
        
        translate([total_internal_width/2 - lanyard_slot_width/2 - lanyard_slot_origin_x, total_internal_length/2 + wall_thickness/2, -1*(total_internal_height/2 - lanyard_slot_height/2 - lanyard_slot_origin_z)]) cube([lanyard_slot_width, lanyard_slot_length, lanyard_slot_height], center=true);
    }
}



module xenon_mounting_posts(){
    //outer posts
    outer_origin_x = -1*(total_internal_width/2 - xenon_post_outer_diameter/2 - xenon_distance_from_wall_x);
    outer_origin_y = -1*(total_internal_length/2 - xenon_post_outer_diameter/2 - xenon_distance_from_wall_y);
    outer_z = -1*(total_internal_height/2 - wall_thickness);
    
    translate([outer_origin_x, outer_origin_y, outer_z]) cylinder(h=xenon_post_outer_height, d=xenon_post_outer_diameter);
    translate([outer_origin_x + xenon_post_distance_apart_x, outer_origin_y, outer_z]) cylinder(h=xenon_post_outer_height, d=xenon_post_outer_diameter);
    translate([outer_origin_x, outer_origin_y + xenon_post_distance_apart_y, outer_z]) cylinder(h=xenon_post_outer_height, d=xenon_post_outer_diameter);
    translate([outer_origin_x + xenon_post_distance_apart_x, outer_origin_y + xenon_post_distance_apart_y, outer_z]) cylinder(h=xenon_post_outer_height, d=xenon_post_outer_diameter);
    
    
    //reinforcement cubes
    reinforcement_cube_extra_x = 1.0;
    reinforcement_cube_extra_y = 2.0;
    
    translate([outer_origin_x, outer_origin_y - 1, outer_z + xenon_post_outer_height/2]) cube([xenon_post_outer_diameter + reinforcement_cube_extra_x,xenon_post_outer_diameter + reinforcement_cube_extra_y,xenon_post_outer_height], center=true);
    translate([outer_origin_x + xenon_post_distance_apart_x, outer_origin_y - 1, outer_z + xenon_post_outer_height/2]) cube([xenon_post_outer_diameter + reinforcement_cube_extra_x,xenon_post_outer_diameter + reinforcement_cube_extra_y,xenon_post_outer_height], center=true);
    translate([outer_origin_x, outer_origin_y + xenon_post_distance_apart_y, outer_z + xenon_post_outer_height/2]) cube([xenon_post_outer_diameter + reinforcement_cube_extra_x,xenon_post_outer_diameter + reinforcement_cube_extra_y,xenon_post_outer_height], center=true);
    translate([outer_origin_x + xenon_post_distance_apart_x, outer_origin_y + xenon_post_distance_apart_y, outer_z + xenon_post_outer_height/2]) cube([xenon_post_outer_diameter + reinforcement_cube_extra_x,xenon_post_outer_diameter + reinforcement_cube_extra_y,xenon_post_outer_height], center=true);
    

    
    // inner posts
    inner_origin_x = -1*(total_internal_width/2 - xenon_post_inner_diameter/2 - xenon_distance_from_wall_x - (xenon_post_outer_diameter-xenon_post_inner_diameter)/2);
    inner_origin_y = -1*(total_internal_length/2 - xenon_post_inner_diameter/2 - xenon_distance_from_wall_y - (xenon_post_outer_diameter-xenon_post_inner_diameter)/2);
    inner_z = -1*(total_internal_height/2 - wall_thickness - xenon_post_outer_height);
    
    translate([inner_origin_x, inner_origin_y, inner_z]) cylinder(h=xenon_post_inner_height, d=xenon_post_inner_diameter);
    translate([inner_origin_x + xenon_post_distance_apart_x, inner_origin_y, inner_z]) cylinder(h=xenon_post_inner_height, d=xenon_post_inner_diameter);
    translate([inner_origin_x, inner_origin_y + xenon_post_distance_apart_y, inner_z]) cylinder(h=xenon_post_inner_height, d=xenon_post_inner_diameter);
    translate([inner_origin_x + xenon_post_distance_apart_x, inner_origin_y + xenon_post_distance_apart_y, inner_z]) cylinder(h=xenon_post_inner_height, d=xenon_post_inner_diameter);
}

module battery_holder(){
    
    
    battery_z = -1*(total_internal_height/2 - wall_thickness - battery_holder_flaps_thickness/2);
    battery_origin_x = total_internal_width/2 - battery_holder_flaps_width/2;
    
    translate([battery_origin_x,battery_holder_flaps_offset_y,battery_z]) cube([battery_holder_flaps_width,battery_holder_flaps_length,battery_holder_flaps_thickness], center=true);
    translate([-1*battery_origin_x,battery_holder_flaps_offset_y,battery_z]) cube([battery_holder_flaps_width,battery_holder_flaps_length,battery_holder_flaps_thickness], center=true);
    
    
}

module led_holder(){
    
    
    led_z = -1*(total_internal_height/2 - wall_thickness - led_holder_flaps_thickness/2 - battery_holder_flaps_thickness);
    led_origin_x = total_internal_width/2 - led_holder_flaps_width/2;
    
    translate([led_origin_x,battery_holder_flaps_offset_y,led_z]) cube([led_holder_flaps_width,led_holder_flaps_length,led_holder_flaps_thickness], center=true);
    translate([-1*led_origin_x,battery_holder_flaps_offset_y,led_z]) cube([led_holder_flaps_width,led_holder_flaps_length,led_holder_flaps_thickness], center=true);
    
    
}

module button_post(){
//    button_post_diameter = 3;
//    button_post_height = xenon_post_outer_height + xenon_post_inner_height;
//    button_post_distance_from_wall_x = 16;
//    button_post_distance_from_wall_y = 30;
    
    translate([-1*(total_internal_width / 2 - wall_thickness - button_post_distance_from_wall_x), -1*(total_internal_length / 2 - wall_thickness - button_post_distance_from_wall_y) , -1*(total_internal_height/2 - wall_thickness)]) cylinder(d=button_post_diameter, h=button_post_height);
}

module button_cutout(){
    cutout_size = 9;
    empty_space = 0.6;
    
    difference(){
        translate([-1*(total_internal_width/2 - cutout_size/2 - button_post_distance_from_wall_x + button_post_diameter + wall_thickness/2),-1*(total_internal_length/2 - cutout_size/2 - button_post_distance_from_wall_y + button_post_diameter), -1*(total_internal_height/2 - cutout_size/2 + wall_thickness)]) cube([cutout_size,cutout_size,cutout_size], center=true);
        
        
        translate([-1*(total_internal_width/2 - cutout_size/2 - button_post_distance_from_wall_x + button_post_diameter + wall_thickness/2 + empty_space),-1*(total_internal_length/2 - cutout_size/2 - button_post_distance_from_wall_y + button_post_diameter), -1*(total_internal_height/2 - cutout_size/2 + wall_thickness)]) cube([cutout_size,cutout_size - empty_space*2,cutout_size+2], center=true);
    }
}

//button_cutout();


module led_window(){
    translate([-1*(total_internal_width/2 - window_size/2 - window_distance_from_wall_x),-1*(total_internal_length/2 - window_size/2 - window_distance_from_wall_y), -1*(total_internal_height/2 - window_size/2 + wall_thickness)]) cube([window_size,window_size,wall_thickness + 2], center=true);
        
}

module xenon_holder(){
    xenon_holder_left_extra_width = 0.4;
    
    translate([-1*(total_internal_width/2 - xenon_holder_width / 2 - xenon_holder_origin_x - xenon_holder_left_extra_width/2), -1 *(total_internal_length/2 - xenon_holder_length / 2  - xenon_holder_origin_y),-1 * (total_internal_height/2 - wall_thickness - xenon_holder_height/2 - xenon_holder_origin_z)]) cube([xenon_holder_width + xenon_holder_left_extra_width,xenon_holder_length,xenon_holder_height], center=true);
    
    
    translate([1*(total_internal_width/2 - xenon_holder_width / 2 - xenon_holder_origin_x), -1 *(total_internal_length/2 - xenon_holder_length / 2  - xenon_holder_origin_y),-1 * (total_internal_height/2 - wall_thickness - xenon_holder_height/2 - xenon_holder_origin_z)]) cube([xenon_holder_width,xenon_holder_length,xenon_holder_height], center=true);
}


module battery_top_holder(){
    translate([-1*(total_internal_width/2 - battery_top_holder_width/2 - battery_top_holder_origin_x), -1 *(total_internal_length/2 - battery_top_holder_length / 2  - battery_top_holder_origin_y),-1 * (total_internal_height/2 - wall_thickness - battery_top_holder_height/2 - battery_top_holder_origin_z)]) cube([battery_top_holder_width,battery_top_holder_length,battery_top_holder_height], center=true);
translate([1*(total_internal_width/2 - battery_top_holder_width / 2 - battery_top_holder_origin_x), -1 *(total_internal_length/2 - battery_top_holder_length / 2  - battery_top_holder_origin_y),-1 * (total_internal_height/2 - wall_thickness - battery_top_holder_height/2 - battery_top_holder_origin_z)]) cube([battery_top_holder_width,battery_top_holder_length,battery_top_holder_height], center=true);
}


module led_ring_antigravity_shelf(){
    translate([0,total_internal_length/2 - led_ring_top_holder_length/2,total_internal_height/2 - led_ring_top_holder_height/2]) cube([led_ring_top_holder_width, led_ring_top_holder_length, led_ring_top_holder_height], center=true);

    translate([total_internal_width/2 - led_ring_antigravity_shelf_width/2, total_internal_length/2 - led_ring_antigravity_shelf_length/2 - led_ring_antigravity_shelf_distance_from_top, total_internal_height/2 - led_ring_antigravity_shelf_height/2]) cube([led_ring_antigravity_shelf_width,led_ring_antigravity_shelf_length,led_ring_antigravity_shelf_height], center=true);

    translate([total_internal_width/2 - led_ring_antigravity_shelf_top_width/2, total_internal_length/2 - led_ring_antigravity_shelf_top_length/2 - led_ring_antigravity_shelf_top_distance_from_top, total_internal_height/2 - led_ring_antigravity_shelf_top_height/2]) cube([led_ring_antigravity_shelf_top_width,led_ring_antigravity_shelf_top_length,led_ring_antigravity_shelf_top_height], center=true);

    translate([-1*(total_internal_width/2 - led_ring_antigravity_shelf_width/2), total_internal_length/2 - led_ring_antigravity_shelf_length/2 - led_ring_antigravity_shelf_distance_from_top, total_internal_height/2 - led_ring_antigravity_shelf_height/2]) cube([led_ring_antigravity_shelf_width,led_ring_antigravity_shelf_length,led_ring_antigravity_shelf_height], center=true);

    translate([-1*(total_internal_width/2 - led_ring_antigravity_shelf_top_width/2), total_internal_length/2 - led_ring_antigravity_shelf_top_length/2 - led_ring_antigravity_shelf_top_distance_from_top, total_internal_height/2 - led_ring_antigravity_shelf_top_height/2]) cube([led_ring_antigravity_shelf_top_width,led_ring_antigravity_shelf_top_length,led_ring_antigravity_shelf_top_height], center=true);
}

main_enclosure();
xenon_mounting_posts();
battery_holder();
led_holder();
button_post();
xenon_holder();
battery_top_holder();
led_ring_antigravity_shelf();
