include <BazzelRoller_Variables.scad>
use <Crush_Ribs.scad>

module bazzleroller_cap() {

difference() {

    // Draw the cap 
    union() {

        color("red") {

            // cap
            cylinder(
                Cap_Width,
                Roller_Tube_Outer_Diameter/2+Cap_Width,
                Roller_Tube_Outer_Diameter/2,
                false,
                $fn=100
            );

            // main body
            translate([0,0,Cap_Width])
            cylinder(
                Bearing_Width,
                Roller_Tube_Inner_Diameter/2,
                Roller_Tube_Inner_Diameter/2,
                false,
                $fn=100
            );

            // top bevel
            translate([0,0,Cap_Width+Bearing_Width])
            cylinder(
                2,
                Roller_Tube_Inner_Diameter/2,
                Roller_Tube_Inner_Diameter/2-2,
                false,
                $fn=100
            );

        }

        if (Number_of_Crush_Ribs>0) {

            color("yellow") {

                // Outer crush ribs
                for (i = [0:Number_of_Crush_Ribs-1]) {

                    rotate ([0,0,i*(360/Number_of_Crush_Ribs)])
                    translate([0,Roller_Tube_Inner_Diameter/2-0.4,Cap_Width])
                    rotate ([3.5,0,0])
                    cylinder(
                        Bearing_Width,
                        1,
                        1,
                        false,
                        $fn=20
                    );

                }
                
            }
            
        }
    };

    // Bearing cutout
    difference() {

        color("blue") {
            union() {

                // bearing body
                translate([0,0,-0.01])
                cylinder(
                    Bearing_Width+0.01,
                    Bearing_Outer_Diameter/2+1,
                    Bearing_Outer_Diameter/2+1,
                    false,
                    $fn=100
                );

                // bearing top bevel
                translate([0,0,Bearing_Width-0.01])
                cylinder(
                    2,
                    Bearing_Outer_Diameter/2+1,
                    Bearing_Outer_Diameter/2-1,
                    false,
                    $fn=100
                );
                
            }
        }

        if (Number_of_Crush_Ribs>0) {

            // Subtract bearing crush rubs from bearing cutout
            color("yellow") {

                // inner crush ribs
                for (i = [0:Number_of_Crush_Ribs-1]) {

                    rotate ([0,0,i*(360/Number_of_Crush_Ribs)])
                    translate([0,Bearing_Outer_Diameter/2+1.8,0])
                    rotate ([3.5,0,0])
                    cylinder(
                        Bearing_Width+1,
                        1,
                        1,
                        false,
                        $fn=20
                    );

                }
                
            }

        };
    };

    // full through cutout
    cylinder(
        Bearing_Width+Cap_Width+4.01,
        Bearing_Outer_Diameter/2-1,
        Bearing_Outer_Diameter/2-1,
        false,
        $fn=100
    );

}

}
