// The outer diameter of the pipe you want to use as your roller, in mm.
Roller_Tube_Outer_Diameter = 33.75;

// The inner diameter of the pipe you want to use as your roller, in mm.
Roller_Tube_Inner_Diameter = 25.75;

// How far the cap should extend beyond the end of the tube, in mm.
Cap_Width = 5;

// The outer diameter of your bearings, in mm.
Bearing_Outer_Diameter = 22;

// The inner diameter of your bearings, in mm.
Bearing_Inner_Diameter = 8;

// The width of your bearings, in mm.
Bearing_Width = 7;

// The thickness of your base, in mm.
Base_Thickness = 5;

// The outer diameter of the stationary support tube, in mm.
Support_Tube_Outer_Diameter = 22.15;

// How high to hold the filament off the ground (in mm, measured from ground to center of rollers). Must be the same or greater than Support_Tube_Outer_Diameter
Base_Height_to_Rollers = 46; 

// How far to place the rollers apart, in mm.
Distance_Between_Rollers = 135;

// If you want to use crush ribs to make up for some inaccuracies in your print, while still allowing tight fits, set this to a non zero value (6 is recommended). If you use crush rubs, you must have at least 3, and the number you choose has to evenly divide into 360. Set to 0 to disable crush ribs completely.
Number_of_Crush_Ribs = 6;

// Do you want to build the base, a single roller cap, or a set of one base and two caps? A complete project will require two bases and 4 roller caps, all created using the same variables.
Type_of_Object = "Set"; // [Set, Base, Cap]


assert(Roller_Tube_Inner_Diameter<Roller_Tube_Outer_Diameter, "Inner diameter of tube must be smaller than outer diameter");
assert(Bearing_Outer_Diameter<Roller_Tube_Inner_Diameter, "Outer diameter of bearings must be less than inner diameter of tube (ie: bearing must be able to fit inside tube)");


if (Number_of_Crush_Ribs>0) {
    assert(Number_of_Crush_Ribs>=3,"If using crush ribs, you'll want at least 3 to keep the item centered (recommend 6)");
    assert((360/Number_of_Crush_Ribs)==floor(360/Number_of_Crush_Ribs),"Number of crush ribs must be equally divisible around a 360 degree circle (ie: 360 divided by number of ribs cannot have a remainder)");
}
