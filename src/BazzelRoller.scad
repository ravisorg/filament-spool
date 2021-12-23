include <BazzelRoller_Variables.scad>

use <BazzelRoller_Base.scad>
use <BazzelRoller_Cap.scad>

if (Type_of_Object=="Set") {
    bazzleroller_base();
    translate([
        ((Roller_Tube_Outer_Diameter/2)+Cap_Width)+2,
        -1*((Roller_Tube_Outer_Diameter/2)+Cap_Width)-2,
        0
    ])
    bazzleroller_cap();
    translate([
        -1*((Roller_Tube_Outer_Diameter/2)+Cap_Width)-2,
        -1*((Roller_Tube_Outer_Diameter/2)+Cap_Width)-2,
        0
    ])
    bazzleroller_cap();

}
if (Type_of_Object=="Base") {
    bazzleroller_base();
}
if (Type_of_Object=="Cap") {
    bazzleroller_cap();
}

