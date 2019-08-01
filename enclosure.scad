include <platonic_solids/test_platonic.scad>


baseSphereDiameter = 100;


module baseSphere(){
        rotate(v=[-1,0,0], a=69)
        display_polyhedron(icosahedron(baseSphereDiameter/2));        
}

module catEars(){
    difference(){
        scaleFactor = 12;
        translateFactor =  5;
        translate([0,-1*baseSphereDiameter/translateFactor,0])
        scale([baseSphereDiameter/scaleFactor,baseSphereDiameter/scaleFactor,baseSphereDiameter/scaleFactor])
        import("catears.stl");
        
    }
}

baseSphere();

catEars();