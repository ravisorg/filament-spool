module crush_ribs(radius,height,count=6,inner=false,angle=3.5) {

    if (inner) {

        difference() {
        
            union() {
            
                for (i = [0:count-1]) {

                    rotate ([0,0,i*(360/count)])
                    translate([0,radius+0.7,0])
                    cylinder(
                        height,
                        1,
                        angle?0.5:1,
                        false,
                        $fn=20
                    );

                }
                
            }

            difference() {
                
                translate([0,0,-0.5])
                cylinder(
                    height+1,
                    radius+3,
                    radius+3,
                    false,
                    $fn=100
                );

                translate([0,0,-1])
                cylinder(
                    height+2,
                    radius,
                    radius,
                    false,
                    $fn=100
                );
                
            }

            
        }
        
    }
                
    else {

        difference() {

            union() {

                for (i = [0:count-1]) {

                    rotate ([0,0,i*(360/count)])
                    translate([0,radius-0.4,0])
                    cylinder(
                        height,
                        1,
                        angle?0.5:1,
                        false,
                        $fn=20
                    );

                }
                
            }
            
            translate([0,0,-0.5])
            cylinder(
                height+1,
                radius,
                radius,
                false,
                $fn=100
            );
            
        }
        
    }
    
}
