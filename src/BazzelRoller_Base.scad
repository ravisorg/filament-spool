include <BazzelRoller_Variables.scad>
use <Crush_Ribs.scad>

module bazzleroller_base() {

Roller_Diameter = Roller_Tube_Outer_Diameter + (Cap_Width*2);
Roller_Padding = 2;
Roller_Border = 2;
Roller_Depth = 2;
Roller_Full_Diameter = Roller_Diameter+(Roller_Padding*2)+(Roller_Border*2);
Support_Tube_Padding = Support_Tube_Outer_Diameter >= 30 ? Support_Tube_Outer_Diameter * 0.15 : 3;
Leg_Width = Support_Tube_Outer_Diameter + Support_Tube_Padding;
Leg_Left = (Distance_Between_Rollers/2)-(Roller_Diameter/2)-(Support_Tube_Outer_Diameter/2)-(Support_Tube_Padding/2);

SupportCenterLeft = Leg_Left + (Support_Tube_Padding*0.45) + (Support_Tube_Outer_Diameter/2);

RollerCenterLeft = (Distance_Between_Rollers/2);

// We need to find out how far away the support cutout
// needs to be from the roller cutout
SupportCenterOffsetX = RollerCenterLeft - SupportCenterLeft;
SupportCenterDiagonal = (Roller_Full_Diameter/2) + (Support_Tube_Outer_Diameter/2) + (Support_Tube_Padding/2);
// Need to find out CurveCenterOffsetY
SupportCenterOffsetY = sqrt((SupportCenterDiagonal*SupportCenterDiagonal) - (SupportCenterOffsetX*SupportCenterOffsetX));


// If the height isn't enough to allow the support tube diameter to fit, increase the height as needed
Minimum_Base_Height_to_Rollers = SupportCenterOffsetY + (Support_Tube_Outer_Diameter/2) + Support_Tube_Padding;
Actual_Base_Height_to_Rollers = Base_Height_to_Rollers < Minimum_Base_Height_to_Rollers ? Minimum_Base_Height_to_Rollers : Base_Height_to_Rollers;
if (Base_Height_to_Rollers<Minimum_Base_Height_to_Rollers) {
    echo("Support tube diameter is ",Support_Tube_Outer_Diameter);
    echo("Roller diameter is ",Roller_Full_Diameter);
    echo("WARNING: Increased base height to ",Minimum_Base_Height_to_Rollers," in order to allow support tube to fit");
}

RollerCenterTop = Actual_Base_Height_to_Rollers;
SupportCenterTop = RollerCenterTop - SupportCenterOffsetY;
Leg_Height = SupportCenterTop;

// We need to find the center of the circle that cuts
// out the body, and at the same time we can figure out
// where the body needs to end to intersect with that.
SideCurveCenterOffsetX = (Leg_Left+Leg_Width)+(Roller_Full_Diameter/2)-RollerCenterLeft;
// Need to find out CurveCenterOffsetY
SideCurveCenterOffsetY = sqrt((Roller_Full_Diameter*Roller_Full_Diameter) - (SideCurveCenterOffsetX*SideCurveCenterOffsetX));

// We need to find the center of the circle that cuts
// out the body, and at the same time we can figure out
// where the body needs to end to intersect with that.
TopCurveCenterOffsetY = (Roller_Full_Diameter/2);
TopCurveCenterOffsetX = sqrt((Roller_Full_Diameter*Roller_Full_Diameter) - (TopCurveCenterOffsetY*TopCurveCenterOffsetY));


BodyTop = RollerCenterTop + (TopCurveCenterOffsetY/2);
BodyRight = RollerCenterLeft + (SideCurveCenterOffsetX/2);

module copy_rotate(vec){
    children();
    mirror(vec)
    children();
}

union() {

copy_rotate([1,0,0]){

    difference() {

        union() {

            difference() {

                // Main body that we'll cut out from to create the curves
                color("yellow") {

                    union() {

                        translate([
                            -0.01,
                            0,
                            0
                        ])
                        cube(
                            size = [
                                BodyRight+0.01,
                                BodyTop, //+10,
                                Base_Thickness
                            ], 
                            center = false
                        );

                        // Roller guide
                        translate([
                            Distance_Between_Rollers/2,
                            Actual_Base_Height_to_Rollers,
                            0
                        ])
                        cylinder(
                            Base_Thickness,
                            (Roller_Diameter)/2+Roller_Padding+Roller_Border,
                            (Roller_Diameter)/2+Roller_Padding+Roller_Border,
                            false,
                            $fn=100
                        );
                     
                    }

                }

                // Cutout between legs
                color("blue") {

                    union() {

                        translate([
                            Leg_Left-9,
                            Leg_Height-9,
                            -0.01
                        ])
                        cylinder(
                            Base_Thickness+0.02,
                            9,
                            9,
                            false,
                            $fn=100
                        );

                        translate([
                            -0.02,
                            -0.01,
                            -0.01
                        ])
                        cube(
                            size = [
                                Leg_Left-9+0.02,
                                Leg_Height+0.01,
                                Base_Thickness+0.02
                            ], 
                            center = false
                        );

                        translate([
                            -0.02,
                            -0.01,
                            -0.01
                        ])
                        cube(
                            size = [
                                Leg_Left+0.02,
                                Leg_Height-9+0.01,
                                Base_Thickness+0.02
                            ], 
                            center = false
                        );
                        
                    }

                }


                // Cutout outside of leg
                color("purple") {

                    union() {

                        translate([
                            RollerCenterLeft+SideCurveCenterOffsetX,
                            RollerCenterTop-SideCurveCenterOffsetY,
                            -0.01
                        ])
                        cylinder(
                            Base_Thickness+0.02,
                            Roller_Full_Diameter/2,
                            Roller_Full_Diameter/2,
                            false,
                            $fn=100
                        );

                        // Fill in the part bottom left of the circle
                        translate([
                            Leg_Left+Leg_Width,
                            -0.01,
                            -0.01
                        ])
                        cube(
                            size = [
                                Roller_Full_Diameter,
                                RollerCenterTop-SideCurveCenterOffsetY+0.01,
                                Base_Thickness+0.02
                            ], 
                            center = false
                        );

                    }

                }



                // Cutout top of body
                color("purple") {

                    union() {

                        translate([
                            RollerCenterLeft-TopCurveCenterOffsetX,
                            RollerCenterTop+TopCurveCenterOffsetY,
                            -0.01
                        ])
                        cylinder(
                            Base_Thickness+0.02,
                            Roller_Full_Diameter/2,
                            Roller_Full_Diameter/2,
                            false,
                            $fn=100
                        );

                        // Fill in the part bottom left of the circle
                        translate([
                            -0.02,
                            RollerCenterTop+TopCurveCenterOffsetY-(Roller_Full_Diameter/2),
                            -0.01
                        ])
                        cube(
                            size = [
                                RollerCenterLeft-TopCurveCenterOffsetX+0.02,
                                Roller_Full_Diameter, //+10,
                                Base_Thickness+0.02
                            ], 
                            center = false
                        );

                    }

                }

                // Support tube
                color("green") {
                    translate([
                        SupportCenterLeft,
                        SupportCenterTop,
                        -0.01]
                    )
                    cylinder(
                        Base_Thickness+0.02,
                        Support_Tube_Outer_Diameter/2,
                        Support_Tube_Outer_Diameter/2,
                        false,
                        $fn=100
                    );
                }

                // Roller cutout
                translate([
                    Distance_Between_Rollers/2,
                    Actual_Base_Height_to_Rollers,
                    Base_Thickness-Roller_Depth
                ])
                color("red") {
                    cylinder(
                        Roller_Depth+0.01,
                        (Roller_Diameter)/2+Roller_Padding,
                        (Roller_Diameter)/2+Roller_Padding,
                        false,
                        $fn=100
                    );
                }

            }

            // Support tube crush ribs
            if (Number_of_Crush_Ribs>0) {
                color("red") {
                    translate([
                        SupportCenterLeft,
                        SupportCenterTop,
                        0]
                    )
                    crush_ribs(
                        Support_Tube_Outer_Diameter/2,
                        Base_Thickness,
                        Number_of_Crush_Ribs,
                        inner=true,
                        angle=false
                    );
                }
            }

            union() {

                // Bearing axel base
                translate([
                    Distance_Between_Rollers/2,
                    Actual_Base_Height_to_Rollers,
                    Base_Thickness-Roller_Depth
                ])
                color("cyan") {
                    cylinder(
                        1+0.01,
                        (Bearing_Inner_Diameter/2)+2,
                        (Bearing_Inner_Diameter/2)+2,
                        false,
                        $fn=100
                    );
                }

                // Bearing axel
                translate([
                    Distance_Between_Rollers/2,
                    Actual_Base_Height_to_Rollers,
                    Base_Thickness-Roller_Depth
                ])
                color("blue") {
                    cylinder(
                        Bearing_Width-1+0.01,
                        (Bearing_Inner_Diameter/2)-0.5,
                        (Bearing_Inner_Diameter/2)-0.5,
                        false,
                        $fn=100
                    );
                }

                // bearing axel bevel
                translate([
                    Distance_Between_Rollers/2,
                    Actual_Base_Height_to_Rollers,
                    Base_Thickness-Roller_Depth+Bearing_Width-1.01
                ])
                cylinder(
                    1.01,
                    (Bearing_Inner_Diameter/2)-0.5,
                    (Bearing_Inner_Diameter/2)-1.5,
                    false,
                    $fn=100
                );

                // Bearing crush ribs
                if (Number_of_Crush_Ribs>0) {
                    color("red") {
                        translate([
                            Distance_Between_Rollers/2,
                            Actual_Base_Height_to_Rollers-0.01,
                            Base_Thickness-Roller_Depth
                        ])
                        crush_ribs(
                            (Bearing_Inner_Diameter/2)-0.5,
                            Bearing_Width-1+0.01,
                            Number_of_Crush_Ribs,
                            angle=true,
                            inner=false
                        );
                    }
                }
                
            }
            
        } // End union
        
        // Axel holes for M3 screws
        translate([
            Distance_Between_Rollers/2,
            Actual_Base_Height_to_Rollers,
            -0.01
        ])
        cylinder(
            Base_Thickness+Bearing_Width+1.01,
            1.5,
            1.5,
            false,
            $fn=100
        );

    } // end difference

}

}

}